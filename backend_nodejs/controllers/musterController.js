const Muster = require("../models/musterModel");
const asyncHandler = require("express-async-handler");
const get = asyncHandler(async (req, res) => {
  res.status(200).json({
    musters: await Muster.find({ uid: req.user.id }),
  });
});
const create = asyncHandler(async (req, res) => {
  await Muster.create({
    uid: req.user.id,
  });
  res.status(200).json({});
});
module.exports = {
  get,
  create,
};
