const asyncHandler = require("express-async-handler");
const User = require("../models/userModel");
const UserTemporary = require("../models/userTemporaryModel");
const Question = require("../models/questionModel");
const login = async(req, res) => {
    if (res.auth) {
        const users = await User.find();
        const user = await User.findOne({ _id: req.user.id });
        const usertemporarys = await UserTemporary.find();
        res.render("admin/manager_account", { user: user, users: users, usertemporarys: JSON.stringify(usertemporarys) });

    } else {
        res.render("admin/login");
    }
    res.end();
};
const manageraccount = async(req, res) => {
    if (res.auth) {
        const users = await User.find();
        const user = await User.findOne({ _id: req.user.id });
        const usertemporarys = await UserTemporary.find();
        res.render("admin/manager_account", { user: user, users: users, usertemporarys: JSON.stringify(usertemporarys) });

    } else {
        res.render("admin/login");
    }
    res.end();
}
const managerquestions = async(req, res) => {
    if (res.auth) {
        const user = await User.findOne({ _id: req.user.id });
        const questions = await Question.find();

        // Tạo một mảng để lưu trữ thông tin typeLanguage và level
        const typeLanguageLevels = [];

        // Duyệt qua từng câu hỏi và thu thập thông tin typeLanguage và level
        questions.forEach((question) => {
            const { typeLanguage, level } = question;

            // Kiểm tra xem typeLanguage đã tồn tại trong mảng typeLanguageLevels chưa
            const existingTypeLanguage = typeLanguageLevels.find((item) => item.typeLanguage === typeLanguage);

            if (existingTypeLanguage) {
                // Nếu typeLanguage đã tồn tại, kiểm tra xem level đã được thêm vào mảng level chưa
                if (!existingTypeLanguage.levels.includes(level)) {
                    // Nếu level chưa tồn tại, thêm nó vào mảng levels
                    existingTypeLanguage.levels.push(level);
                }
            } else {
                // Nếu typeLanguage chưa tồn tại, tạo một đối tượng mới chứa thông tin typeLanguage và mảng levels
                typeLanguageLevels.push({
                    typeLanguage,
                    levels: [level],
                });
            }
        });

        console.log(typeLanguageLevels);
        res.render("admin/manager_questions", { user: user, questions: questions, typeLanguageLevels: typeLanguageLevels });

    } else {
        res.render("admin/login");
    }
    res.end();
}
module.exports = { login, manageraccount, managerquestions };