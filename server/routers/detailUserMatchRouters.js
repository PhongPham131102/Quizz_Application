const express = require("express");
const router = express.Router();
const {get, getfollowid } = require("../controllers/detailUserMatchController");
const validateToken = require("../middleware/validateTokenHandler");
router.get("/get", validateToken, get);
router.post("/getfollowid", validateToken, getfollowid);
module.exports = router;