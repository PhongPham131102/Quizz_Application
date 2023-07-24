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
const questionThemeSchema = mongoose.Schema({
    uid: {
        type: String,
        required: true,
    },
    title: {
        type: String,
        required: true,
    },
    answers: {
        type: [answerSchema],
        required: true,
    },
    score: {
        type: Number,
        required: true,
    },
    image: {
        type: String,
        default: "",
    },
    time: {
        type: Number,
        required: true,
    },
    theme: {
        type: String,
        required: true,
    },
}, {
    timestamps: true,
});

module.exports = mongoose.model("QuestionTheme", questionThemeSchema);