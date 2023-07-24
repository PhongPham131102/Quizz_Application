const mongoose = require("mongoose");
const userTopicSchema = mongoose.Schema(
  {
    uid: {
      type: String,
    },
    topicType: {
      type: String,
    },
    levelHightest: {
      type: Number,
      default: 1,
    },
    totalScore: {
      type: Number,
      default: 0,
    },
    completed: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true,
  }
);
module.exports = mongoose.model("UserTopic", userTopicSchema);
