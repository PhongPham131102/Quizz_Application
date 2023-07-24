const express = require("express");
const router = express.Router();
const { create,getall } = require("../controllers/usersItemController");
const validateToken = require("../middleware/validateTokenHandler");
router.post("/create",validateToken,create);
router.get("/getall",validateToken,getall);
module.exports = router;