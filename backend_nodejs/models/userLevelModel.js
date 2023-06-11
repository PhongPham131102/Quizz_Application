const mongoose = require("mongoose");
const userLevelSchema = mongoose.Schema(
  {
    uid: {
      type: String,
    },
    topicType: {
      type: String,
    },
    level: {
      type: Number,
      default: 1,
    },
    score: {
      type: Number,
      default: 0,
    },
    star: {
        type: Number,
        default: 0,
      },
  },
  {
    timestamps: true,
  }
);
module.exports = mongoose.model("UserLevel", userLevelSchema);
