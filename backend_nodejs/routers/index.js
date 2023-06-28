var express = require("express");
var router = express.Router();
var path = require("path");
//trang chủ
router.get("/", function (req, res, next) {
  const filePath = path.join(__dirname, "..", "views", "index.html");
  res.sendFile(filePath);
});
//trang đăng nhập
router.get("/login", function (req, res, next) {
  const filePath = path.join(__dirname, "..", "views", "login.html");
  res.sendFile(filePath);
});
//trang đăng ký
router.get("/register", function (req, res, next) {
  const filePath = path.join(__dirname, "..", "views", "register.html");
  res.sendFile(filePath);
});
//trang quên mật khẩu
router.get("/forgetpassword", function (req, res, next) {
  const filePath = path.join(__dirname, "..", "views", "forgetpassword.html");
  res.sendFile(filePath);
});
//trang quên mật khẩu
router.get("/otp", function (req, res, next) {
  const filePath = path.join(__dirname, "..", "views", "fillotp.html");
  res.sendFile(filePath);
});
//trang quên mật khẩu
router.get("/repassword", function (req, res, next) {
  const filePath = path.join(__dirname, "..", "views", "repassword.html");
  res.sendFile(filePath);
});
//trang tài khoản cá nhân
router.get("/account", function (req, res, next) {
  const filePath = path.join(__dirname, "..", "views", "account.html");
  res.sendFile(filePath);
});
//trang kết quả làm bài
router.get("/result", function (req, res, next) {
  const filePath = path.join(__dirname, "..", "views", "result.html");
  res.sendFile(filePath);
});
//trang giao diện chính để tạo bộ câu hỏi
router.get("/home", function (req, res, next) {
  const filePath = path.join(__dirname, "..", "views", "home.html");
  res.sendFile(filePath);
});
//trang giao diện chính để tạo bộ câu hỏi
router.get("/createquestions", function (req, res, next) {
  const filePath = path.join(__dirname, "..", "views", "createquestion.html");
  res.sendFile(filePath);
});
module.exports = router;
