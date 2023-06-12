const express = require("express");
const router = express.Router();
const { getall} = require("../controllers/userLevelController");
const validateToken = require("../middleware/validateTokenHandler");
router.post("/getall",validateToken, getall);
module.exports = router;

