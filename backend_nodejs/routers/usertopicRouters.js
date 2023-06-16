const express = require("express");
const router = express.Router();
const { getall,getalluser} = require("../controllers/userTopicController");
const validateToken = require("../middleware/validateTokenHandler");
router.get("/getall",validateToken, getall);
router.get("/getalluser", getalluser);
module.exports = router;
