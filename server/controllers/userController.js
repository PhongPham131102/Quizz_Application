const User = require("../models/userModel");
const UserTemporary = require("../models/userTemporaryModel");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const asyncHandler = require("express-async-handler");
const registerUser = asyncHandler(async(req, res) => {
    const { fullName, email, password, isTeacher, isAdmin } = req.body;
    const usertemporaryAvailable = await UserTemporary.findOne({ email });
    const usertAvailable = await User.findOne({ email });
    if (usertAvailable || usertemporaryAvailable) {
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
        isTeacher: isTeacher ? isTeacher : false,
        isAdmin: isAdmin ? isAdmin : false,
    });
    console.log(user);
    if (user) {
        res.status(201).json({
            _id: user.id,
            user: user,
        });
    } else {
        res.status(404);
        throw new Error("Database Error");
    }
});

const loginUser = asyncHandler(async(req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        res.status(400);
        throw new Error("All Fields are mandatory!");
    }
    const user = await User.findOne({ email });
    if (user && (await bcrypt.compare(password, user.password))) {
        const accessToken = jwt.sign({
                user: {
                    id: user.id,
                },
            },
            process.env.ACCESS_TOKEN_SECERT, { expiresIn: "1d" }
        );
        user.token = accessToken;
        await user.save();
        req.io.emit(`login${user.id}`, { user: user.id });
        res.status(200).json({
            token: accessToken,
            id: user.id,
            user: user,
        });
    } else {
        res.status(401);
        throw new Error("email or password incorrect");
    }
});
const checkToken = asyncHandler(async(req, res) => {
    res.status(200).json({
        user: req.user,
    });
});
const checkMail = asyncHandler(async(req, res) => {
    const email = req.body.email;
    const user = await User.findOne({ email });
    if (user) {
        res.status(200).send();
    } else {
        res.status(400).send();
    }
});
const updatePassWord = asyncHandler(async(req, res) => {
    const { email, password } = req.body;
    console.log(email, password);
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
const changepassword = asyncHandler(async(req, res) => {
    const { currentPassword, newPassword } = req.body;
    console.log(currentPassword);
    console.log(newPassword);
    const user = await User.findOne({ _id: req.user.id });
    console.log(await bcrypt.compare(currentPassword, user.password));
    if (await bcrypt.compare(currentPassword, user.password)) {
        user.password = await bcrypt.hash(newPassword, 10);
        user.save();
        res.status(200).send();
    } else {
        res.status(400).send();
    }
});
const getuser = asyncHandler(async(req, res) => {
    const user = await User.findOne({ _id: req.user.id });
    res.status(200).json({ user: user });
});

const update = asyncHandler(async(req, res) => {
    const { fullName, email, isAdmin, isTeacher } = req.body;
    const user = await User.findOne({ _id: req.body.id });
    const checkUserMail = await User.findOne({ email: email, _id: { $ne: user._id } });
    if (checkUserMail) {
        res.status(403).send();
    } else {
        

        user.fullName = fullName;
        user.email = email;
        user.isAdmin = isAdmin;
        user.isTeacher = isTeacher;
        user.save();
        res.status(200).json({ user: user });
    }
});
const deleteUser = asyncHandler(async(req, res) => {
    const userId = req.params.id;

    // Tìm người dùng dựa trên id và xóa nếu tìm thấy
    const user = await User.findByIdAndRemove(userId);

    if (user) {
        res.status(200).json({ message: "Người dùng đã được xóa" });
    } else {
        res.status(404).json({ message: "Không tìm thấy người dùng" });
    }
});
module.exports = {
    deleteUser,
    registerUser,
    loginUser,
    checkToken,
    checkMail,
    updatePassWord,
    changepassword,
    getuser,
    update,
};