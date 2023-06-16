const mongoose = require("mongoose");
const musterSchema = mongoose.Schema(
  {
    uid: {
      type: String,
      require: true,
    },
  },
  {
    timestamps: true,
  }
);
module.exports = mongoose.model("Muster", musterSchema);
