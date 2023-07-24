const mongoose = require("mongoose");

const usersitemSchema = mongoose.Schema(
  {
    idItem: {
      type: String,
      required: true,
    },
    uid: {
      type: String,
      required: true,
    },
    quantity: {
      type: Number,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("UsersItem", usersitemSchema);
