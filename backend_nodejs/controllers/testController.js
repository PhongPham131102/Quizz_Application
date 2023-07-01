const Test = require("../models/testModel");
const asyncHandler = require("express-async-handler");
const get = asyncHandler(async(req, res) => {
    res.status(200).json({
        tests: await Test.find({ uid: req.user.id }),
    });
});
const create = asyncHandler(async(req, res) => {

    await Test.create({
        uid: req.user.id,
        heading: req.body.heading,
        testTheme: req.body.testTheme,
        typePost: req.body.typePost,
        listQuestions: [],
    });
    res.send();
});
module.exports = {
    get,
    create,
};