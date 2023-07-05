const QuestionTheme = require("../models/questionThemeModel");
const asyncHandler = require("express-async-handler");
const getquestiontheme = asyncHandler(async(req, res) => {
    var topicTheme = req.body.testTheme;
    console.log(topicTheme);
    var lsitQuestionTheme = await QuestionTheme.find({ theme: topicTheme });
    res.status(200).json({
        lsitQuestionTheme
    });
});
module.exports = {
    getquestiontheme,
};