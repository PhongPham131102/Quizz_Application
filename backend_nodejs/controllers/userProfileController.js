const UserProfile = require("../models/userProfileModel");
const asyncHandler = require("express-async-handler");
const getProfile = asyncHandler(async (req, res) => {
  console.log(req.user.id);
  let profile = await UserProfile.findOne({ uid: req.user.id });
  if (profile) {
    console.log("get");
    res.status(200).json({ profile: profile });
  } else {
    console.log("create");
    profile = await UserProfile.create({
      uid: req.user.id,
    });
    res.status(200).json({ profile: profile });
  }
});
const updategender = asyncHandler(async (req, res) => {
  let profile = await UserProfile.findOne({ uid: req.user.id });
  profile.gender = req.body.gender;
  await profile.save();
  if (profile.gender == "") {
    res.status(400).send();
  } else {
    res.status(201).send();
  }
});
const updatename = asyncHandler(async (req, res) => {
  let profile = await UserProfile.findOne({ uid: req.user.id });
  profile.name = req.body.name;
  await profile.save();
  if (profile.name == "") {
    res.status(400).send();
  } else {
    res.status(201).send();
  }
});
const addgold = asyncHandler(async (req, res) => {
  let profile = await UserProfile.findOne({ uid: req.user.id });
  profile.gold += req.body.gold;
  await profile.save();
  console.log(`profile${profile.uid}`);
  req.io.emit(`profile${profile.uid}`,{profile:profile});
  res.send();
});
module.exports = {
  getProfile,
  updategender,
  updatename,
  addgold,
};
