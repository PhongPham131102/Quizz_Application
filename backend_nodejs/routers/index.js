var express = require("express");
var router = express.Router();
var path = require("path");
const csrf = require("csurf");
const User = require("../models/userModel");
const validateTokenteacher = require("../middleware/validateTeacherHandler");
//trang chủ
router.get("/", validateTokenteacher, async function(req, res, next) {
    if (res.auth) {
        const user = await User.findOne({ _id: req.user.id });
        res.render("home", { fullName: user.fullName });
    } else {
        res.render("index");
    }
});
//trang đăng nhập
router.get("/login", validateTokenteacher, async function(req, res, next) {
    if (res.auth) {
        const user = await User.findOne({ _id: req.user.id });
        res.render("home", { fullName: user.fullName });
    } else {
        res.render("login");
    }
});
//trang đăng ký
router.get("/register", validateTokenteacher, async function(req, res, next) {
    if (res.auth) {
        const user = await User.findOne({ _id: req.user.id });
        res.render("home", { fullName: user.fullName });
    } else {
        res.render("register");
    }
});
//trang quên mật khẩu
router.get(
    "/forgetpassword",
    validateTokenteacher,
    async function(req, res, next) {
        if (res.auth) {
            const user = await User.findOne({ _id: req.user.id });
            res.render("home", { fullName: user.fullName });
        } else {
            res.render("forgetpassword");
        }
    }
);
//trang quên mật khẩu
router.get(
    "/otp/:gmail",
    validateTokenteacher,
    csrf({ cookie: true }),
    async function(req, res, next) {
        console.log(req.params.gmail);
        if (res.auth) {
            const user = await User.findOne({ _id: req.user.id });
            res.render("home", { fullName: user.fullName });
        } else {
            res.render("fillotp", {
                email: req.params.gmail,
                csrfToken: req.csrfToken(),
            });
        }
    }
);
//trang tài khoản cá nhân
router.get("/account", validateTokenteacher, async function(req, res, next) {
    if (res.auth) {
        const user = await User.findOne({ _id: req.user.id });
        res.render("account", { fullName: user.fullName, email: user.email });
    } else {
        res.render("login");
    }
});
//trang giao diện chính để tạo bộ câu hỏi
router.get("/home", validateTokenteacher, async function(req, res, next) {
    if (res.auth) {
        const user = await User.findOne({ _id: req.user.id });
        res.render("home", { fullName: user.fullName });
    } else {
        res.render("login");
    }
});
//trang kết quả làm bài
router.get("/result", validateTokenteacher, function(req, res, next) {
    if (res.auth) {
        res.render("result");
    } else {
        res.render("login");
    }
});
//trang giao diện chính để tạo bộ câu hỏi
router.get("/createquestions", validateTokenteacher, function(req, res, next) {
    if (res.auth) {
        res.render("createquestion");
    } else {
        res.render("login");
    }
});

module.exports = router;