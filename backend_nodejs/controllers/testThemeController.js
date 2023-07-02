const TestTheme = require("../models/testThemeModel");
const asyncHandler = require("express-async-handler");
// const createNestedStructure = (data, parentId = "") => {
//     const nestedData = [];
//     data.forEach(item => {
//         if (item.parent == parentId) {
//             const children = createNestedStructure(data, item._id);
//             const newItem = {
//                 _id: item.id,
//                 topic: item.topic,
//             };
//             if (children.length > 0) {
//                 newItem.children = children;
//             }
//             nestedData.push(newItem);
//         }
//     });
//     return nestedData;
// };

// const getall = asyncHandler(async(req, res) => {
//     const testThemes = await TestTheme.find({ uid: req.user.id });
//     console.log(testThemes.length);
//     const programmingLanguages = createNestedStructure(testThemes);

//     res.json(programmingLanguages).status(200);
// });
const create = asyncHandler(async(req, res) => {
    const { topic, parent } = req.body;
    const createdTestTheme = await TestTheme.create({
        uid: req.user.id,
        topic,
        parent,
    });
    res.status(201).json(createdTestTheme);
});
module.exports = {
    // getall,
    create,
};