const express = require("express");
const router = express.Router();
const {get,create} = require("../controllers/musterController");
const validateToken = require("../middleware/validateTokenHandler");
router.get("/get",validateToken, get);
router.get("/create",validateToken, create);
module.exports = router;