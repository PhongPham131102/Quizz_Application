const User = require("../models/userModel");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const asyncHandler = require("express-async-handler");
const registerUser = asyncHandler(async (req, res) => {
  const { fullName, email, password, isTeacher } = req.body;
  if (!fullName || !email || !password) {
    res.status(400);
    const error = new Error("All fields are mandatory!");
    error.data = { userAlready: true };
    throw error;
  }
  const userAvailable = await User.findOne({ email });
  if (userAvailable) {
    res.status(400);
    throw new Error("User already registtered!");
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
    res.status(400);
    throw new Error("User data us not valid");
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
      { expiresIn: "30d" }
    );
    res.status(200).json(accessToken);
  } else {
    res.status(401);
    throw new Error("email or password incorrect");
  }
});
module.exports = {
  registerUser,
  loginUser,
};
