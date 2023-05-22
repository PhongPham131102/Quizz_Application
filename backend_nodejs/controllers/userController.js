const User = require("../models/userModel");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const asyncHandler = require("express-async-handler");
const registerUser = asyncHandler(async (req, res) => {
  const { fullName, email, password, isTeacher } = req.body;
  const userAvailable = await User.findOne({ email });
  if (userAvailable) {
    res.status(400);
    const error = new Error("User Already Register");
    throw error;
  }
  //Hash password
  const hashedPassword = await bcrypt.hash(password, 10);
  const user = await User.create({
    fullName,
    email,
    password: hashedPassword,
    isTeacher: isTeacher ?? false,
  });
  console.log(user);
  if (user) {
    res.status(201).json({
      _id: user.id,
    });
  } else {
    res.status(404);
    throw new Error("Database Error");
  }
});

const loginUser = asyncHandler(async (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    res.status(400);
    throw new Error("All Fields are mandatory!");
  }
  const user = await User.findOne({ email });
  if (user && (await bcrypt.compare(password, user.password))) {
    const accessToken = jwt.sign(
      {
        user: {
          id: user.id,
        },
      },
      process.env.ACCESS_TOKEN_SECERT,
      { expiresIn: "1d" }
    );
    user.token = accessToken;
    await user.save();
    res.status(200).json({
      token: accessToken,
      id: user.id,
    });
  } else {
    res.status(401);
    throw new Error("email or password incorrect");
  }
});
const checkToken = asyncHandler(async (req, res) => {
  res.status(200).json({
    user: req.user,
  });
});
const checkMail = asyncHandler(async (req, res) => {
  const email = req.body.email;
  const user = await User.findOne({ email });
  if (user) {
    res.status(200).send();
  } else {
    res.status(400).send();
  }
});
const updatePassWord = asyncHandler(async (req, res) => {
  const { email, password } = req.body;
  const user = await User.findOne({ email });
  const hashedPassword = await bcrypt.hash(password, 10);
  user.password = hashedPassword;
  await user.save();
  console;
  if (hashedPassword === user.password) {
    res.status(201).send();
  } else {
    res.status(400).send();
  }
});

module.exports = {
  registerUser,
  loginUser,
  checkToken,
  checkMail,
  updatePassWord,

};
