const UserLevel = require("../models/userLevelModel");
const asyncHandler = require("express-async-handler");
const getall = asyncHandler(async (req, res) => {
  console.log(await UserLevel.find({
    uid: req.user.id,
    topicType: req.body.topicType,
  }));
  res.status(200).json({
    userslevels: await UserLevel.find({
      uid: req.user.id,
      topicType: req.body.topicType,
    }),
  });
});
module.exports = {
  getall,
};
