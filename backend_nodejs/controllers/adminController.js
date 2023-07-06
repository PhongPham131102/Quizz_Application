const asyncHandler = require("express-async-handler");
const User = require("../models/userModel");
const UserTemporary = require("../models/userTemporaryModel");
const login = async(req, res) => {
    if (res.auth) {
        const users = await User.find();
        const user = await User.findOne({ _id: req.user.id });
        const usertemporarys = await UserTemporary.find();
        res.render("admin/manager_account", { user: user, users: users, usertemporarys: JSON.stringify(usertemporarys) });

    } else {
        res.render("admin/login");
    }
};
const manageraccount = async(req, res) => {
    if (res.auth) {
        const users = await User.find();
        const user = await User.findOne({ _id: req.user.id });
        const usertemporarys = await UserTemporary.find();
        res.render("admin/manager_account", { user: user, users: users, usertemporarys: JSON.stringify(usertemporarys) });

    } else {
        res.render("admin/login");
    }

}
module.exports = { login, manageraccount };