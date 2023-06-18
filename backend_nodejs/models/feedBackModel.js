const mongoose = require("mongoose");
const feedbackSchema = mongoose.Schema(
  {
    uid: {
      type: String,
    },
    content: {
      type: String,
      require:true
    },
  },
  {
    timestamps: true,
  }
);
module.exports = mongoose.model("FeedBack", feedbackSchema);
