const Question = require("../models/questionModel");
const asyncHandler = require("express-async-handler");

const create = asyncHandler(async(req, res) => {
    const {
        title,
        answers,
        score,
        time,
        typeQuestion,
        typeLanguage,
        level,
    } = req.body;
    console.log(req.body);
    // Tạo một câu hỏi mới dựa trên dữ liệu từ req.body
    const question = await Question.create({
        title,
        answers,
        score,
        time,
        typeQuestion,
        typeLanguage,
        level,
    });
    if (question) {
        res.status(201).json({
            success: true,
            message: "Câu hỏi đã được tạo thành công",
            data: question,
        });
    } else {
        res.status(400).json({
            success: false,
            message: "Không thể tạo câu hỏi",
        });
    }
});

const createmutiple = asyncHandler(async(req, res) => {
    const questions = req.body;

    // Mảng để lưu các câu hỏi đã được tạo thành công
    const createdQuestions = [];

    // Lặp qua từng câu hỏi trong mảng
    for (let i = 0; i < questions.length; i++) {
        const {
            title,
            answers,
            difficulty,
            score,
            image,
            time,
            typeQuestion,
            typeLanguage,
            level,
            idPost,
        } = questions[i];

        // Tạo một câu hỏi mới dựa trên dữ liệu từ mảng câu hỏi
        const question = await Question.create({
            title,
            answers,
            difficulty,
            score,
            time,
            image,
            typeQuestion,
            typeLanguage,
            level,
            idPost,
        });

        if (question) {
            createdQuestions.push(question);
        }
    }

    if (createdQuestions.length > 0) {
        res.status(201).json({
            success: true,
            message: "Các câu hỏi đã được tạo thành công",
            data: createdQuestions,
        });
    } else {
        res.status(400).json({
            success: false,
            message: "Không thể tạo câu hỏi",
        });
    }
});
const getall = asyncHandler(async(req, res) => {
    res.status(200).json({
        message: await Question.find({ typeLanguage: "c++" }).limit(5),
    });
});
const getquestiontopic = asyncHandler(async(req, res) => {
    res.status(200).json({
        question: await Question.find({
            typeLanguage: req.body.typeLanguage,
            level: req.body.level,
        }).limit(5),
    });
});
const deleteQuestion = asyncHandler(async(req, res) => {
    const id = req.params.id;

    // Tìm người dùng dựa trên id và xóa nếu tìm thấy
    const question = await Question.findByIdAndRemove(id);

    if (user) {
        res.status(200).json({ message: "Câu hỏi đã được xóa" });
    } else {
        res.status(404).json({ message: "Không tìm thấy Câu hỏi" });
    }
});
const update = asyncHandler(async(req, res) => {
    const {
        title,
        answers,
        score,
        time,
        typeQuestion,
        typeLanguage,
        level,
    } = req.body;
    const { id } = req.params;

    // Tìm câu hỏi dựa trên id
    let question = await Question.findById(id);

    if (question) {
        // Cập nhật thông tin của câu hỏi
        question.title = title;
        question.answers = answers;
        question.score = score;
        question.time = time;
        question.typeQuestion = typeQuestion;
        question.typeLanguage = typeLanguage;
        question.level = level;

        // Lưu câu hỏi đã cập nhật
        question = await question.save();

        res.status(200).json({
            success: true,
            message: "Câu hỏi đã được cập nhật thành công",
            data: question,
        });
    } else {
        res.status(404).json({
            success: false,
            message: "Câu hỏi không tồn tại",
        });
    }
});

module.exports = {
    create,
    update,
    createmutiple,
    getall,
    getquestiontopic,
    deleteQuestion
};