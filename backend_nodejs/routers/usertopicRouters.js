const express = require("express");
const router = express.Router();
const { getall} = require("../controllers/userTopicController");
const validateToken = require("../middleware/validateTokenHandler");
router.get("/getall",validateToken, getall);
module.exports = router;
