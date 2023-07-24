const UserTemporary = require("../models/userTemporaryModel");
const User = require("../models/userModel");
const bcrypt = require("bcrypt");
const asyncHandler = require("express-async-handler");
const registerUser = asyncHandler(async(req, res) => {
    const { fullName, email, password } = req.body;
    const usertemporaryAvailable = await UserTemporary.findOne({ email });
    const usertAvailable = await User.findOne({ email });
    if (usertAvailable || usertemporaryAvailable) {
        res.status(409);
        const error = new Error("User Already Register");
        throw error;
    }
    const user = await UserTemporary.create({
        fullName,
        email,
        password,
    });
    if (user) {
        console.log("create");
        res.status(201).json({
            _id: user.id,
        });
    } else {
        res.status(404);
        throw new Error("Database Error");
    }
});
const convertTeacher = asyncHandler(async(req, res) => {
    const usertemporaryAvailable = await UserTemporary.findOne({
        _id: req.body.id,
    });
    const hashedPassword = await bcrypt.hash(usertemporaryAvailable.password, 10);
    const user = await User.create({
        fullName: usertemporaryAvailable.fullName,
        email: usertemporaryAvailable.email,
        password: hashedPassword,
        isTeacher: true,
        isAdmin: false,
    });
    console.log(user);
    if (user) {
        await UserTemporary.deleteOne({ _id: usertemporaryAvailable._id });
        res.status(201).json({
            _id: user.id,
            user: user,
        });
    } else {
        res.status(404);
        throw new Error("Database Error");
    }
});
const deleteaccount = asyncHandler(async(req, res) => {
    const usertemporaryAvailable = await UserTemporary.findOne({
        _id: req.body.id,
    });
    await UserTemporary.deleteOne({ _id: usertemporaryAvailable._id });
    res.status(200);
});

module.exports = {
    registerUser,
    convertTeacher,
    deleteaccount,
};