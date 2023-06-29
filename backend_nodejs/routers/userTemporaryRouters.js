const express = require("express");
const router = express.Router();
const { registerUser, } = require("../controllers/userTemporaryController");
router.post("/register", registerUser);
module.exports = router;