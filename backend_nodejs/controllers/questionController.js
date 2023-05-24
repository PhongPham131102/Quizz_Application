const Question = require("../models/questionModel");
const asyncHandler = require("express-async-handler");

const create = asyncHandler(async (req, res) => {
  const {
    title,
    answers,
    difficulty,
    score,
    image,
    typeQuestion,
    typeLanguage,
    level,
    idPost,
  } = req.body;

  // Tạo một câu hỏi mới dựa trên dữ liệu từ req.body
  const question = await Question.create({
    title,
    answers,
    difficulty,
    score,
    image,
    typeQuestion,
    typeLanguage,
    level,
    idPost,
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

const createmutiple = asyncHandler(async (req, res) => {
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
const getall = asyncHandler(async (req, res) => {
  res.status(200).json({
    message: await Question.find({ typeLanguage: "c++" }).limit(5),
  });
});
module.exports = {
  create,
  createmutiple,
  getall,
};
