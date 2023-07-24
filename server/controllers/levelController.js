const Level = require("../models/levelModel");
const UserProfile = require("../models/userProfileModel");
const UsersTopic = require("../models/userTopicModel");
const UsersLevel = require("../models/userLevelModel");
const asyncHandler = require("express-async-handler");

const create = asyncHandler(async(req, res) => {
    const { topicType, title, level } = req.body;

    // Kiểm tra tính duy nhất của topicType và level
    const existingLevel = await Level.findOne({ topicType, level });
    if (existingLevel) {
        return res.status(400).json({
            success: false,
            message: "Đã tồn tại level với cùng topicType và level",
        });
    }

    // Tạo một level mới dựa trên dữ liệu từ req.body
    const newLevel = await Level.create({ topicType, title, level });

    if (newLevel) {
        res.status(201).json({
            success: true,
            message: "Level đã được tạo thành công",
            data: newLevel,
        });
    } else {
        res.status(400).json({
            success: false,
            message: "Không thể tạo Level",
        });
    }
});
const createMultiple = asyncHandler(async(req, res) => {
    const levels = req.body;

    // Kiểm tra tính hợp lệ của từng level
    for (const levelData of levels) {
        const { topicType, level } = levelData;

        // Kiểm tra tính duy nhất của topicType và level
        const existingLevel = await Level.findOne({ topicType, level });
        if (existingLevel) {
            return res.status(400).json({
                success: false,
                message: `Đã tồn tại level với cùng topicType: ${topicType} và level: ${level}`,
            });
        }
    }

    // Tạo các level mới
    const newLevels = await Level.create(levels);

    if (newLevels) {
        res.status(201).json({
            success: true,
            message: "Các level đã được tạo thành công",
            data: newLevels,
        });
    } else {
        res.status(400).json({
            success: false,
            message: "Không thể tạo các level",
        });
    }
});
const getall = asyncHandler(async(req, res) => {
    res.status(200).json({
        levels: await Level.find({
            topicType: req.body.topicType,
        }),
    });
});
const summary = asyncHandler(async(req, res) => {
    const uid = req.user.id;
    UserProfile.findOne({ uid })
        .then(async(userProfile) => {
            let star = 0;
            let topicType = req.body.topicType;
            let level = req.body.level;
            let usersScore = req.body.usersScore;
            let maxScore = req.body.maxScore;
            let gold = req.body.gold;

            let expEarned = Math.floor(Math.random() * (100 - 80 + 1) + 80) * level;
            let result = levelUp(userProfile.level, userProfile.exp, expEarned);
            let oldLevel = userProfile.level;
            let oldexp = userProfile.exp;
            if (result.newLevel > oldLevel) {
                req.io.emit(`levelup${userProfile.uid}`, { level: result.newLevel });
            }
            userProfile.level = result.newLevel;
            userProfile.exp = result.remainingExp;
            userProfile.gold = gold + usersScore;
            await userProfile.save();
            let userlevel = await UsersLevel.findOne({
                uid: uid,
                topicType: topicType,
                level: level,
            });
            let userTopic = await UsersTopic.findOne({
                uid: uid,
                topicType: topicType,
            });

            if (usersScore >= maxScore) {
                star = 3;
                // cập nhật điểm cao nhất
                if (usersScore > userlevel.score) {
                    userlevel.star = 3;
                    userTopic.totalScore =
                        userTopic.totalScore - userlevel.score + usersScore;
                    userlevel.score = usersScore;
                }
                //kiểm tra level tiếp theo có tồn tại không
                let nextlevel = await Level.findOne({
                    level: level + 1,
                    topicType: topicType,
                });
                //nếu tồn tại thì mở level tiếp theo
                if (nextlevel) {
                    //kiểm tra xem level cao nhất của chủ đề này có nhỏ hơn level mà người chơi vừa gửi không nếu có thì cập nhật lại
                    if (userTopic.levelHightest < level + 1) {
                        userTopic.levelHightest = level + 1;
                    }
                    //kiểm tra level tiếp theo của người dùng đã tạo chưa
                    let nextuserlevel = await UsersLevel.findOne({
                        uid: uid,
                        topicType: topicType,
                        level: level + 1,
                    });
                    //nếu chưa tạo thì tạo mới
                    if (!nextuserlevel) {
                        await UsersLevel.create({
                            uid: req.user.id,
                            topicType: topicType,
                            level: level + 1,
                        });
                        req.io.emit(`openlevel${userProfile.uid}`, { level: level + 1, topicType: topicType });
                    }
                }
            } else if (usersScore >= maxScore / 2) {
                star = 2;
                // cập nhật điểm cao nhất
                if (usersScore > userlevel.score) {
                    userlevel.star = 2;
                    userTopic.totalScore =
                        userTopic.totalScore - userlevel.score + usersScore;
                    userlevel.score = usersScore;
                }
                //kiểm tra level tiếp theo có tồn tại không
                let nextlevel = await Level.findOne({
                    level: level + 1,
                    topicType: topicType,
                });
                //nếu tồn tại thì mở level tiếp theo
                if (nextlevel) {
                    //kiểm tra xem level cao nhất của chủ đề này có nhỏ hơn level mà người chơi vừa gửi không nếu có thì cập nhật lại
                    if (userTopic.levelHightest < level + 1) {
                        userTopic.levelHightest = level + 1;
                    }

                    //kiểm tra level tiếp theo của người dùng đã tạo chưa
                    let nextuserlevel = await UsersLevel.findOne({
                        uid: uid,
                        topicType: topicType,
                        level: level + 1,
                    });
                    //nếu chưa tạo thì tạo mới
                    if (!nextuserlevel) {
                        console.log("create new level");
                        await UsersLevel.create({
                            uid: req.user.id,
                            topicType: topicType,
                            level: level + 1,
                        });
                        req.io.emit(`openlevel${userProfile.uid}`, { level: level + 1, topicType: topicType });
                    }
                }
            } else if (usersScore >= maxScore / 4) {
                star = 1;
                // cập nhật điểm cao nhất
                if (usersScore > userlevel.score) {
                    userlevel.star = 1;
                    userTopic.totalScore =
                        userTopic.totalScore - userlevel.score + usersScore;
                    userlevel.score = usersScore;
                }
            }

            await userTopic.save();
            await userlevel.save();
            let userlevels = await UsersLevel.find({
                uid: uid,
                topicType: topicType,
            });
            console.log(userlevels);
            req.io.emit(`topic${userProfile.uid}`, { userTopic: userTopic });
            req.io.emit(`levels${userProfile.uid}`, { userlevels: userlevels });
            req.io.emit(`profile${userProfile.uid}`, { profile: userProfile });

            res.status(200).json({
                star: star,
                //cấp cũ
                oldLevel: oldLevel,
                //kinh nghiệm nhận được
                expEarned: expEarned,
                //kinh nghiệm cũ
                oldexp: oldexp,
                //kinh nghiệm hiện tại
                nowexp: userProfile.exp,
                //cấp mới
                newLevel: result.newLevel,
                //vàng nhận được bằng số điểm người chơi đạt được
                gold: usersScore,
            });
        })
        .catch((error) => {
            console.error(error);
            res.status(500).json({ message: "Server error" });
        });
});

function levelUp(currentLevel, currentExp, expEarned) {
    let expNeeded = currentLevel * 100;
    let remainingExp = currentExp + expEarned;
    let levelsGained = 0;

    while (remainingExp >= expNeeded) {
        currentLevel++;
        remainingExp -= expNeeded;
        levelsGained++;
        expNeeded = currentLevel * 100;
    }

    return { newLevel: currentLevel, remainingExp, levelsGained };
}
module.exports = {
    create,
    createMultiple,
    getall,
    summary,
};