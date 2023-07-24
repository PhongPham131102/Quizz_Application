const mongoose = require("mongoose");
const levelSchema = mongoose.Schema(
  {
    topicType: {
      type: String,
    },
    title: {
      type: String,
    },
    level: {
      type: Number,
    },
  },
  {
    timestamps: true,
  }
);
module.exports = mongoose.model("Level", levelSchema);
