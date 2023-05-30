const mongoose = require("mongoose");
const { Schema } = mongoose;
const itemSchema = mongoose.Schema(
  {
    _id: {
      type: String,
      default: () => new mongoose.Types.ObjectId() 
    },
    name: {
      type: String,
      required: true,
    },
    shortName: {
      type: String,
      required: true,
    },
    type: {
      type: String,
      required: true,
    },
    detailType: {
      type: String,
      required: true,
    },
    gender: {
      type: String,
      required: true,
    },
    typeMoney: {
      type: String,
      required: true,
    },
    price: {
      type: Number,
      default: 0,
    },
    quantityPurchasable: {
      type: Boolean,
      default: false,
    },
    buyAble: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Item", itemSchema);
