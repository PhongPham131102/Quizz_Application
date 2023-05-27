const mongoose = require("mongoose");

const matchSchema = mongoose.Schema(
  {
    room: {
      type: String,
      required: true,
    },
    winner: {
      type: String,
    },
    topic: {
      type: String,
    },
    player1: {
      type: String,
      required: true,
    },
    player2: {
      type: String,
      required: true,
    },
    questionsid: {
      type: [String],
      required: true,
    },
    score1: {
      type: Number,
      default: 0,
    },
    score2: {
      type: Number,
      default: 0,
    },
    answer1: {
      type: [
        {
          index: Number,
          selectedIndex: Number,
          idAnswer: String,
        },
      ],
      default: [],
    },
    answer2: {
      type: [
        {
          index: Number,
          selectedIndex: Number,
          idAnswer: String,
        },
      ],
      default: [],
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Match", matchSchema);
