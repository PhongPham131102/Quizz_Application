var express = require("express");
const TestTheme = require("../models/testThemeModel");
const Test = require("../models/testModel");
const QuestionTheme = require("../models/questionThemeModel");
var router = express.Router();
var path = require("path");
const csrf = require("csurf");
const User = require("../models/userModel");
const {
    validateTokenteacher,
} = require("../middleware/validateTeacherHandler");
//trang chủ
router.get("/", validateTokenteacher, async function(req, res, next) {
    if (res.auth) {
        const user = await User.findOne({ _id: req.user.id });
        const tests = await Test.find({ uid: req.user.id });
        res.render("home", { fullName: user.fullName, tests: tests });
    } else {
        res.render("index");
    }
    res.end();
});
//trang đăng nhập
router.get("/login", validateTokenteacher, async function(req, res, next) {
    if (res.auth) {
        const user = await User.findOne({ _id: req.user.id });
        const tests = await Test.find({ uid: req.user.id });
        res.render("home", { fullName: user.fullName, tests: tests });
    } else {
        res.render("login");
    }
    res.end();
});
//trang đăng ký
router.get("/register", validateTokenteacher, async function(req, res, next) {
    if (res.auth) {
        const user = await User.findOne({ _id: req.user.id });
        const tests = await Test.find({ uid: req.user.id });
        res.render("home", { fullName: user.fullName, tests: tests });
    } else {
        res.render("register");
    }
    res.end();
});
//trang quên mật khẩu
router.get(
    "/forgetpassword",
    validateTokenteacher,
    async function(req, res, next) {
        if (res.auth) {
            const user = await User.findOne({ _id: req.user.id });
            const tests = await Test.find({ uid: req.user.id });
            res.render("home", { fullName: user.fullName, tests: tests });
        } else {
            res.render("forgetpassword");
        }
        res.end();
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
            const tests = await Test.find({ uid: req.user.id });
            res.render("home", { fullName: user.fullName, tests: tests });
        } else {
            res.render("fillotp", {
                email: req.params.gmail,
                csrfToken: req.csrfToken(),
            });
        }
        res.end();
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
    res.end();
});
//trang giao diện chính để tạo bộ câu hỏi
router.get("/home", validateTokenteacher, async function(req, res, next) {
    if (res.auth) {
        const user = await User.findOne({ _id: req.user.id });
        const tests = await Test.find({ uid: req.user.id });
        res.render("home", { fullName: user.fullName, tests: tests });
    } else {
        res.render("login");
    }
    res.end();
});
//trang kết quả làm bài
router.get("/result", validateTokenteacher, function(req, res, next) {
    if (res.auth) {
        res.render("result");
    } else {
        res.render("login");
    }
    res.end();
});
//trang giao diện chính để tạo bộ câu hỏi
router.get(
    "/createquestions",
    validateTokenteacher,
    async function(req, res, next) {
        if (res.auth) {
            const testThemes = await TestTheme.find({ uid: req.user.id });
            const testThemesObject = testThemes.map((theme) => theme.toObject());
            res.render("createquestion", { testThemes: testThemesObject });
        } else {
            res.render("login");
        }
        res.end();
    }
);
//trang giao diện chỉnh sửa bộ câu hỏi
router.get(
    "/editquestion/:idtest",
    validateTokenteacher,
    async function(req, res, next) {
        if (res.auth) {
            const idtest = req.params.idtest;
            const test = await Test.findOne({ uid: req.user.id, _id: idtest });
            const testObject = test.toObject();
            const listQuestions = test.listQuestions;
            const questionThemes = await QuestionTheme.find({
                _id: { $in: listQuestions },
            });
            const questionThemesObject = questionThemes.map((theme) =>
                theme.toObject()
            );
            const testThemes = await TestTheme.find({ uid: req.user.id });
            const testThemesObject = testThemes.map((theme) => theme.toObject());
            res.render("editquestion", {
                testThemes: testThemesObject,
                test: JSON.stringify(testObject),
                questions: JSON.stringify(questionThemesObject),
            });
        } else {
            res.render("login");
        }
        res.end();
    }
);
//trang giao diện chính để tạo bộ câu hỏi
router.get(
    "/start/:idPost",
    validateTokenteacher,
    async function(req, res, next) {
        let idPost = req.params.idPost;
        let test = await Test.findOne({ _id: idPost });
        let listQuestions = [];
        for (const element of test.listQuestions) {
            const question = await QuestionTheme.findOne({ _id: element });
            listQuestions.push(question.toObject());
        }
        console.log(listQuestions);
        if (res.auth) {
            res.render("waiting-player", {
                test: JSON.stringify(test),
                questions: JSON.stringify(listQuestions),
            });
        } else {
            res.render("login");
        }
        res.end();
    }
);
router.get("/test", function(req, res) {
    res.render("start-game");
    res.end();
});
module.exports = router;
module.exports = router;