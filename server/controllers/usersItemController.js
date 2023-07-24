const UsersItem = require("../models/userItemModel");
const Profile = require("../models/userProfileModel");
const asyncHandler = require("express-async-handler");

const create = asyncHandler(async (req, res) => {
  const { idItem, quantity,typeMoney,price } = req.body;
  let userItem = await UsersItem.findOne({ idItem, uid: req.user.id });
  let profile =await Profile.findOne({ uid: req.user.id });
  console.log(profile);
  if (userItem) {
    if (typeMoney == "gold") {
      profile.gold -= price;
    } else {
      profile.diamond -= price;
    }
    profile.save();
    req.io.emit(`profile${profile.uid}`, { profile: profile });
    userItem.quantity += quantity;
    userItem
      .save()
      .then((result) => {
        res.status(200).json({
          success: true,
          message: "cập nhật vật phẩm người dùng thành công",
          data: userItem,
        });
      })
      .catch((err) => {
        res.status(400).json({
          success: false,
          message: "Không thể cập nhật",
        });
      });
  } else {
    let newitem = await UsersItem.create({
      idItem,
      uid: req.user.id,
      quantity,
    });
    console.log(newitem);
    if (typeMoney == "gold") {
      profile.gold -= price;
    } else {
      profile.diamond -= price;
    }
    profile.save();
    req.io.emit(`profile${profile.uid}`, { profile: profile });
    if (newitem) {
      res.status(201).json({
        success: true,
        message: "vật phẩm người dùng đã được tạo thành công",
        data: newitem,
      });
    } else {
      res.status(400).json({
        success: false,
        message: "Không thể tạo vật phẩm người dùng",
      });
    }
  }
});
const getall = asyncHandler(async (req, res) => {
  res.status(200).json({
    usersitems: await UsersItem.find({ uid: req.user.id }),
  });
});
module.exports = {
  create,
  getall,
};
