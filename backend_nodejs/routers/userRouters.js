const express = require("express");
const router = express.Router();
const { registerUser, loginUser,checkToken } = require("../controllers/userController");
const validateToken=require("../middleware/validateTokenHandler");
router.post("/register", registerUser);
router.post("/login", loginUser);
router.get("/checkToken",validateToken,checkToken);
module.exports = router;
