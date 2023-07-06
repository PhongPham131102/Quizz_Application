const asyncHandler = require("express-async-handler");
const jwt = require("jsonwebtoken");
const User = require("../models/userModel");
const validateTokenAdminOnWeb = asyncHandler(async(req, res, next) => {
    let token;
    token = req.cookies.accessToken;
    if (!token) {
        res.auth = false;
        next();
    }
    jwt.verify(token, process.env.ACCESS_TOKEN_SECERT, async(err, decoded) => {
        if (err) {
            res.auth = false;
            next();
        }
        if (typeof decoded !== "undefined") {
            let infouser = decoded.user;
            const user = await User.findOne({ _id: infouser.id });
            if (user) {
                if (user.token == token) {
                    if (user.isAdmin === true) {
                        req.user = decoded.user;
                        res.auth = true;
                        next();
                    } else {
                        res.auth = false;;
                        next();
                    }
                } else {
                    res.auth = false;
                    next();
                }
            } else {
                res.auth = false;
                next();
            }
        }
    });
});
module.exports = { validateTokenAdminOnWeb };