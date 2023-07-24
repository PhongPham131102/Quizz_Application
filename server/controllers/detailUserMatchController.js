const detailUserMatch = require("../models/detailUserMatchModel");
const asyncHandler = require("express-async-handler");
const get = asyncHandler(async(req, res) => {
    res.status(200).json({
        detailUserMatch: await detailUserMatch.findOne({ uid: req.user.id }),
    });
});
const getfollowid = asyncHandler(async(req, res) => {
    console.log(req.body.id);
    res.status(200).json({
        detailUserMatch: await detailUserMatch.findOne({ uid: req.body.id }),
    });
});
module.exports = {
    get,
    getfollowid
};