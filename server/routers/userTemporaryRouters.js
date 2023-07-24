const express = require("express");
const router = express.Router();
const { registerUser, convertTeacher, deleteaccount } = require("../controllers/userTemporaryController");
const validateTokenAdminHandler = require("../middleware/validateTokenAdminHandler");
router.post("/register", registerUser);
router.post("/convertTeacher", validateTokenAdminHandler, convertTeacher);
router.post("/deleteaccount", validateTokenAdminHandler, deleteaccount);
module.exports = router;