const express = require("express");
const router = express.Router();
const { create, getall } = require("../controllers/testThemeController");
const validateToken = require("../middleware/validateTokenHandler");
router.get("/getall", validateToken, getall);
router.post("/create", validateToken, create);
module.exports = router;