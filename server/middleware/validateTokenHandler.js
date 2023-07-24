const asyncHandler = require("express-async-handler");
const jwt = require("jsonwebtoken");
const User = require("../models/userModel");
const validateToken = asyncHandler(async (req, res, next) => {
  let token;
  let authHeader = req.headers.Authorization || req.headers.authorization;
  if (authHeader && authHeader.startsWith("Bearer")) {
    token = authHeader.split(" ")[1];
    if (!token) {
      res.status(401);
      next(new Error("User is not authorized or token is missing"));
    }
    jwt.verify(token, process.env.ACCESS_TOKEN_SECERT, async (err, decoded) => {
      if (err) {
        res.status(401);
        next(new Error("User is not authorized"));
      }
      if (typeof decoded !== "undefined") {
        let infouser = decoded.user;
        const user = await User.findOne({ _id: infouser.id });
        if (user) {
          if (user.token == token) {
            req.user = decoded.user;
            next();
          } else {
            res.status(401);
            next(new Error("User is not authorized"));
          }
        } else {
          res.status(401);
          next(new Error("User is not authorized"));
        }
      }
    });
  } else {
    res.status(401);
    next(new Error("User is not authorized"));
  }
});
module.exports = validateToken;
