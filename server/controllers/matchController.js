const Match = require("../models/matchModel");
const asyncHandler = require("express-async-handler");
const getUserMatch = asyncHandler(async (req, res) => {
    const userId = req.user.id;
    const matches = await Match.find({
      $or: [{ player1: userId }, { player2: userId }],
    }).populate('questions');
  
    if (matches.length > 0) {
      const transformedMatches = matches.map(match => {
        const transformedQuestions = match.questions.map(question => {
          return {
            _id: question._id,
            title: question.title,
            answers: question.answers,
            difficulty: question.difficulty,
            score: question.score,
            image: question.image,
            typeQuestion: question.typeQuestion,
            typeLanguage: question.typeLanguage,
            level: question.level,
            idPost: question.idPost,
            createdAt: question.createdAt,
            updatedAt: question.updatedAt,
            __v: question.__v
          };
        });
  
        return {
          _id: match._id,
          room: match.room,
          winner: match.winner,
          topic: match.topic,
          player1: match.player1,
          player2: match.player2,
          questions: transformedQuestions,
          score1: match.score1,
          score2: match.score2,
          answer1: match.answer1,
          answer2: match.answer2,
          createdAt: match.createdAt,
          updatedAt: match.updatedAt,
          __v: match.__v
        };
      });
  
      res.status(200).json({ matches: transformedMatches });
    } else {
      res.status(204).json({ message: "No matches found" });
    }
  });
module.exports = {
  getUserMatch,
};
