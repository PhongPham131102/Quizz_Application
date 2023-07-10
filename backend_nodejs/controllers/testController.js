const Test = require("../models/testModel");
const QuestionTheme = require("../models/questionThemeModel");
const asyncHandler = require("express-async-handler");
const fs = require("fs-extra");
const path = require("path");
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
        listQuestions: questions.map((question) => question.toString()),
    });
    res.json({
        test: test,
        questions: questions,
    });
});

async function createMutilQuestion(questionthemes, uid, theme) {
    const createdQuestions = [];
    for (let i = 0; i < questionthemes.length; i++) {
        const { title, answers, score, image, time } = questionthemes[i];
        const question = await QuestionTheme.create({
            uid,
            title,
            answers,
            score,
            time,
            theme: theme,
        });
        if (image != "") {
            let base64Data = image.replace(/^data:image\/\w+;base64,/, "");
            const buffer = Buffer.from(base64Data, "base64");
            let address = `public/images/${uid}/${theme}${question._id.toString()}.png`;
            await fs.ensureDir(path.dirname(address));
            fs.writeFileSync(address, buffer);
            question.image = `/images/${uid}/${theme}${question._id.toString()}.png`;
            question.save();
        }

        if (question) {
            console.log(question);
            createdQuestions.push(question._id);
        }
    }
    return createdQuestions;
}
const edit = asyncHandler(async(req, res) => {
    const testId = req.body.testId;
    const updatedTest = await Test.findById(testId);
    console.log("have");
    if (!updatedTest) {
        res.status(404);
        throw new Error("Test not found");
    }

    // Cập nhật thông tin bài kiểm tra
    updatedTest.heading = req.body.heading;
    updatedTest.testTheme = req.body.idTheme;
    updatedTest.typePost = req.body.typePost;

    // Cập nhật danh sách câu hỏi
    const questionThemes = req.body.questionThemes;
    //console.log(updatedTest.listQuestions);
    const updatedQuestions = await updateMultipleQuestions(
        questionThemes,
        req.user.id,
        req.body.idTheme,
        updatedTest.listQuestions
    );
    updatedTest.listQuestions = updatedQuestions.map((question) =>
        question._id.toString()
    );

    // Lưu các thay đổi
    await updatedTest.save();

    res.json({
        test: updatedTest,
        questions: updatedQuestions,
    });
});

async function updateMultipleQuestions(
    questionthemes,
    uid,
    theme,
    listQuestionsIdOld
) {
    const updatedQuestions = [];
    var listQuestionsUpdate = [];
    for (let i = 0; i < questionthemes.length; i++) {
        const { _id, title, answers, score, image, time } = questionthemes[i];
        if (_id) {

            listQuestionsUpdate.push(_id);
            const updatedQuestion = await QuestionTheme.findByIdAndUpdate(
                _id, {
                    uid,
                    title,
                    answers,
                    score,
                    time,
                    theme,
                }, { new: true }
            );
            updatedQuestions.push(updatedQuestion);
            if (image != "") {
                if (/^data:image\/\w+;base64,/.test(image)) {
                    let base64Data = image.replace(/^data:image\/\w+;base64,/, "");
                    const buffer = Buffer.from(base64Data, "base64");
                    let address = `public/images/${uid}/${theme}${updatedQuestion._id.toString()}.png`;
                    await fs.ensureDir(path.dirname(address));
                    fs.writeFileSync(address, buffer);
                    updatedQuestion.image = `/images/${uid}/${theme}${updatedQuestion._id.toString()}.png`;
                    await updatedQuestion.save();
                }
            } else {
                const question = await QuestionTheme.findById(_id);
                if (question.image) {
                    // Xóa hình ảnh liên quan nếu có
                    const imagePath = `public${question.image}`;
                    fs.unlinkSync(imagePath);
                }
                updatedQuestion.image = ``;
                await updatedQuestion.save();
            }
        } else {
            const newQuestion = await QuestionTheme.create({
                uid,
                title,
                answers,
                score,
                time,
                theme,
            });
            updatedQuestions.push(newQuestion);
            if (image != "") {
                if (/^data:image\/\w+;base64,/.test(image)) {
                    let base64Data = image.replace(/^data:image\/\w+;base64,/, "");
                    const buffer = Buffer.from(base64Data, "base64");
                    let address = `public/images/${uid}/${theme}${newQuestion._id.toString()}.png`;
                    await fs.ensureDir(path.dirname(address));
                    fs.writeFileSync(address, buffer);
                    newQuestion.image = `/images/${uid}/${theme}${newQuestion._id.toString()}.png`;
                    await newQuestion.save();
                } else {
                    const sourceImagePath = "public" + image;
                    let destinationImagePath = `public/images/${uid}/${theme}${newQuestion._id.toString()}.png`;
                    fs.copyFileSync(sourceImagePath, destinationImagePath);
                    newQuestion.image = `/images/${uid}/${theme}${newQuestion._id.toString()}.png`;
                    await newQuestion.save();
                }
            } else {
                newQuestion.image = ``;
                await newQuestion.save();
            }
        }
    }
    const missingQuestions = listQuestionsIdOld.filter(
        (questionId) => !listQuestionsUpdate.includes(questionId)
    );
    for (const questionId of missingQuestions) {
        const question = await QuestionTheme.findById(questionId);
        if (question.image) {
            // Xóa hình ảnh liên quan nếu có
            const imagePath = `public${question.image}`;
            fs.unlinkSync(imagePath);
        }

        // Xóa câu hỏi từ cơ sở dữ liệu
        await QuestionTheme.findByIdAndRemove(questionId);
    }
    return updatedQuestions;
}

module.exports = {
    get,
    create,
    edit,
};