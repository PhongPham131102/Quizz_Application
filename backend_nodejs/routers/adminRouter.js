const express = require("express");
const router = express.Router();
const { login, manageraccount, managerquestions } = require("../controllers/adminController");
const { validateTokenAdminOnWeb } = require("../middleware/validateTokenAdminOnWebHandler");
router.get("/", validateTokenAdminOnWeb, login);
router.get("/login", validateTokenAdminOnWeb, login);
router.get("/manageraccount", validateTokenAdminOnWeb, manageraccount);
router.get("/managerquestions", validateTokenAdminOnWeb, managerquestions);
module.exports = router;