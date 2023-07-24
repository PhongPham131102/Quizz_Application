const express = require("express");
const router = express.Router();
const {get, create, edit } = require("../controllers/testController");
const { validateTokenteacher, validateTeacherHandlerForPhone } = require("../middleware/validateTeacherHandler");
router.get("/get", validateTeacherHandlerForPhone, get);
router.post("/create", validateTeacherHandlerForPhone, create);
router.post("/edit", validateTeacherHandlerForPhone, edit);
module.exports = router;