const express = require("express");
const router = express.Router();
const { get} = require("../controllers/detailUserMatchController");
const validateToken = require("../middleware/validateTokenHandler");
router.get("/get",validateToken, get);
module.exports = router;
