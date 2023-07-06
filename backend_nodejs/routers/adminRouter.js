const express = require("express");
const router = express.Router();
const { login, manageraccount } = require("../controllers/adminController");
const { validateTokenAdminOnWeb } = require("../middleware/validateTokenAdminOnWebHandler");
router.get("/login", validateTokenAdminOnWeb, login);
router.get("/manageraccount", validateTokenAdminOnWeb, manageraccount);
module.exports = router;