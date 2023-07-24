const express = require("express");
const router = express.Router();
const { getquestiontheme } = require("../controllers/questionThemeController");
router.post("/getquestiontheme", getquestiontheme);
module.exports = router;