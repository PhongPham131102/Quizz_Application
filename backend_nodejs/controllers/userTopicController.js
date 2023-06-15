const userTopic = require("../models/userTopicModel");
const asyncHandler = require("express-async-handler");
const getall = asyncHandler(async (req, res) => {
  res.status(200).json({
    userstopics: await userTopic.find({ uid: req.user.id }),
  });
});
module.exports = {
  getall,
};
