const mongoose = require("mongoose");
const userSchema = mongoose.Schema(
  {
    uid: {
      type: String,
      require: true,
    },
    gender: {
      type: String,
      default:"",
    },
    gold: {
      type: Number,
      default:99,
    },
    diamond: {
      type: Number,
      default:0,
    },
    level: {
      type: Number,
      default: 1,
    },
    name: {
      type: String,
      default: "",
    },
    star: {
      type: Number,
      default: 0,
    },
    exp: {
      type: Number,
      default: 0,
    },
    medalId: {
      type: String,
      default: "",
    },
    shirt: {
      type: String,
      default: "blue",
    },
    trouser: {
      type: String,
      default: "blue",
    },
    shoe: {
      type: String,
      default: "white",
    },
    bag: {
      type: String,
      default: "blue",
    },
  },
  {
    timestamps: true,
  }
);
module.exports = mongoose.model("UserProfile", userSchema);
