const mongoose = require("mongoose");
const userSchema = mongoose.Schema(
  {
    fullName: {
      type: String,
      required: [true, "Please add the full name"],
    },
    email: {
      type: String,
      required: [true, "Please add the user email address"],
      unique: [true, "Email address already taken"],
    },
    password: {
      type: String,
      required: [true, "Please add the password"],
    },
    isAdmin: {
      type: Boolean,
      default: false,
    },
    isTeacher: {
      type: Boolean,
      default: false,
    },
    token:{
      type:String,
      default:""
    }
  },
  {
    timestamps: true,
  }
);
module.exports = mongoose.model("User", userSchema);
