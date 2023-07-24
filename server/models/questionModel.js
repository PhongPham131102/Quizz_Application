const mongoose = require("mongoose");
const answerSchema = new mongoose.Schema({
    answerText: {
        type: String,
        required: true,
    },
    score: {
        type: Boolean,
        required: true,
    },
});
const questionSchema = mongoose.Schema({
    title: {
        type: String,
        required: true,
    },
    answers: {
        type: [answerSchema],
        required: true,
    },
    difficulty: {
        type: Number,
        default: 1,
    },
    score: {
        type: Number,
        default: 10,
    },
    time: {
        type: Number,
        default: 10,
    },
    image: {
        type: String,
        default: "",
    },
    typeQuestion: {
        type: String,
        required: true,
    },
    typeLanguage: {
        type: String,
        required: true,
    },
    level: {
        type: Number,
        default: 0,
    },
}, {
    timestamps: true,
});

module.exports = mongoose.model("Question", questionSchema);