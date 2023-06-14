const mongoose = require("mongoose");
const detailUserMathSchema = mongoose.Schema(
  {
    uid: {
      type: String,
      require:true,
    },
    numOfMatchCss: {
      type: Number,
      default: 0,
    },
    numOfWinMatchCss: {
      type: Number,
      default: 0,
    },
    numOfMatchCPlusPlus: {
      type: Number,
      default: 0,
    },
    numOfWinMatchCPlusPlus: {
      type: Number,
      default: 0,
    },
    numOfMatchSql: {
      type: Number,
      default: 0,
    },
    numOfWinMatchSql: {
      type: Number,
      default: 0,
    },
    numOfMatchHtml: {
      type: Number,
      default: 0,
    },
    numOfWinMatchHtml: {
      type: Number,
      default: 0,
    },
  },
  {
    timestamps: true,
  }
);
module.exports = mongoose.model("DetailUserMatch", detailUserMathSchema);
