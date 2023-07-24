const express = require("express");
const router = express.Router();
const { getall, getalluser, getallfollowid } = require("../controllers/userTopicController");
const validateToken = require("../middleware/validateTokenHandler");
router.get("/getall", validateToken, getall);
router.post("/getallfollowid", validateToken, getallfollowid);
router.get("/getalluser", getalluser);
module.exports = router;