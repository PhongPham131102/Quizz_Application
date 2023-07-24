const userTopic = require("../models/userTopicModel");
const UserProfile = require("../models/userProfileModel");
const asyncHandler = require("express-async-handler");
const getall = asyncHandler(async(req, res) => {
    res.status(200).json({
        userstopics: await userTopic.find({ uid: req.user.id }),
    });
});
const getallfollowid = asyncHandler(async(req, res) => {

    res.status(200).json({
        userstopics: await userTopic.find({ uid: req.body.id }),
    });
});
const getalluser = asyncHandler(async(req, res) => {
    try {
        const results = await userTopic.aggregate([
            // Sort by totalScore descending and updatedAt ascending
            { $sort: { topicType: 1, totalScore: -1, updatedAt: 1 } },
            // Group by topicType and push top 10 documents to userTopics array
            {
                $group: {
                    _id: "$topicType",
                    userTopics: { $push: "$$ROOT" },
                },
            },
            // Slice the userTopics array to get top 10 documents
            {
                $project: {
                    topicType: "$_id",
                    userTopics: { $slice: ["$userTopics", 10] },
                },
            },
        ]);
        const userTopics = results.flatMap((topic) => topic.userTopics);
        const uidList = userTopics.map((userTopic) => userTopic.uid);
        let profiles = await UserProfile.find({ uid: { $in: uidList } });
        res.status(200).json({
            userstopics: userTopics,
            profiles: profiles,
        });
    } catch (error) {
        console.error(error);
    }
});
module.exports = {
    getall,
    getalluser,
    getallfollowid,
};