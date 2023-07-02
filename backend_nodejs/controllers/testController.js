const Test = require("../models/testModel");
const QuestionTheme = require("../models/questionThemeModel");
const asyncHandler = require("express-async-handler");
const fs = require('fs');
const path = require('path');
const questionThemeModel = require("../models/questionThemeModel");
const get = asyncHandler(async(req, res) => {
    res.status(200).json({
        tests: await Test.find({ uid: req.user.id }),
    });
});
const create = asyncHandler(async(req, res) => {
    idTheme = req.body.idTheme;
    uid = req.user.id;
    questionThemes = req.body.questionThemes;
    questions = await createMutilQuestion(questionThemes, uid, idTheme);
    test = await Test.create({
        uid: uid,
        heading: req.body.heading,
        testTheme: req.body.idTheme,
        typePost: req.body.typePost,
        listQuestions: questions.map(question => question.toString()),
    });
    res.json({
        test: test,
        questions: questions
    });
});

async function createMutilQuestion(questionthemes, uid, theme) {
    const createdQuestions = [];
    for (let i = 0; i < questionthemes.length; i++) {
        const {
            title,
            answers,
            score,
            image,
            time,
        } = questionthemes[i];
        const question = await QuestionTheme.create({
            uid,
            title,
            answers,
            score,
            time,
            theme: theme,
        });
        if (image != "") {
            let base64Data = image.replace(/^data:image\/\w+;base64,/, '');
            const buffer = Buffer.from(base64Data, 'base64');
            let address = `public/images/${uid}/${theme}${question._id.toString()}.png`;
            fs.writeFileSync(address, buffer);
            question.image = address;
            address.save();
        }


        if (question) {
            console.log(question);
            createdQuestions.push(question._id);
        }
    }
    return createdQuestions;
}
module.exports = {
    get,
    create,
};