const express = require("express");
const router = express.Router();
const { registerUser, loginUser,checkToken,checkMail,updatePassWord} = require("../controllers/userController");
const validateToken=require("../middleware/validateTokenHandler");
router.post("/register", registerUser);
router.post("/login", loginUser);
router.get("/checkToken",validateToken,checkToken);
router.post("/checkMail",checkMail);
router.post("/updatePassWord",updatePassWord);

module.exports = router;
