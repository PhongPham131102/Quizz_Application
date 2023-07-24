const express = require("express");
const router = express.Router();
const {
  create,
  createMultiple,
  getall,
  summary,
} = require("../controllers/levelController");
const validateTokenAdmin = require("../middleware/validateTokenAdminHandler");
const validateToken = require("../middleware/validateTokenHandler");
router.post("/create", validateTokenAdmin, create);
router.post("/createmutiple", validateTokenAdmin, createMultiple);
router.post("/getall", validateToken, getall);
router.post("/summary",validateToken,summary);
module.exports = router;
