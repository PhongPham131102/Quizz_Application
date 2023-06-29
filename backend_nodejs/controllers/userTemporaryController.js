const UserTemporary = require("../models/userTemporaryModel");
const User = require("../models/userModel");
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

module.exports = {
    registerUser,
};