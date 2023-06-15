const detailUserMatch = require("../models/detailUserMatchModel");
const asyncHandler = require("express-async-handler");
const get = asyncHandler(async (req, res) => {
  res.status(200).json({
    detailUserMatch: await detailUserMatch.findOne({ uid: req.user.id }),
  });
});
module.exports = {
  get,
};
