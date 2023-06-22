const Muster = require("../models/musterModel");
const UserProfile = require("../models/userProfileModel");
const asyncHandler = require("express-async-handler");
const get = asyncHandler(async (req, res) => {
  console.log("muster");
  res.status(200).json({
    musters: await Muster.find({ uid: req.user.id }),
  });
});
const create = asyncHandler(async (req, res) => {
  console.log("ok");  
  console.log(req.body.gold);
  await Muster.create({
    uid: req.user.id,
  });
  let profile = await UserProfile.findOne({ uid: req.user.id });
  profile.gold += req.body.gold;
  profile.diamond += req.body.diamond;
  let result = levelUp(profile.level, profile.exp, req.body.exp);
  profile.level = result.newLevel;
  profile.exp = result.remainingExp;
  await profile.save();
  req.io.emit(`profile${profile.uid}`, { profile: profile });
  res.send();
});
function levelUp(currentLevel, currentExp, expEarned) {
  let expNeeded = currentLevel * 100;
  let remainingExp = currentExp + expEarned;
  let levelsGained = 0;

  while (remainingExp >= expNeeded) {
    currentLevel++;
    remainingExp -= expNeeded;
    levelsGained++;
    expNeeded = currentLevel * 100;
  }

  return { newLevel: currentLevel, remainingExp, levelsGained };
}
module.exports = {
  get,
  create, 
};
