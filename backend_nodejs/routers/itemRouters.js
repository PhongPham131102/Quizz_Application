const express = require("express");
const router = express.Router();
const { create,createmutiple,getall } = require("../controllers/itemController");
const validateToken = require("../middleware/validateTokenHandler");
const validateTokenAdmin=require("../middleware/validateTokenAdminHandler");
router.post("/create",validateTokenAdmin,create);
router.post("/createmutiple",validateTokenAdmin,createmutiple);
router.post("/getall",getall);
module.exports = router;