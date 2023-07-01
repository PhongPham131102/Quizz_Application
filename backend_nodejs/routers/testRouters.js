const express = require("express");
const router = express.Router();
const {get, create } = require("../controllers/testController");
const { validateTokenteacher, validateTeacherHandlerForPhone } = require("../middleware/validateTeacherHandler");
router.get("/get", validateTeacherHandlerForPhone, get);
router.post("/create", validateTeacherHandlerForPhone, create);
module.exports = router;