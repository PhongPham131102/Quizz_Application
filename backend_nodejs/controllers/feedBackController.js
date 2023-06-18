const feedBack = require("../models/feedBackModel");
const asyncHandler = require("express-async-handler");
const create = asyncHandler(async (req, res) => {
    console.log(req.body.content);
  if (req.body.content === undefined || req.body.content == "")
    res.status(400).send();
  await feedBack.create({ uid: req.user.uid, content: req.body.content });
  res.status(200).send();
});
module.exports = {
  create,
};
