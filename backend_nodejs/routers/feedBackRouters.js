const express = require("express");
const router = express.Router();
const { create } = require("../controllers/feedBackController");
const validateToken = require("../middleware/validateTokenHandler");
router.post("/create", validateToken,create);
module.exports = router;
