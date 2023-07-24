const express = require("express");
const router = express.Router();
const { getUserMatch } = require("../controllers/matchController");
const validateToken = require("../middleware/validateTokenHandler");
router.get("/getusermatch",validateToken,getUserMatch);
module.exports = router;