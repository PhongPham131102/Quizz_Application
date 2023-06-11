const Level = require("../models/levelModel");
const asyncHandler = require("express-async-handler");

const create = asyncHandler(async (req, res) => {
  const { topicType,title, level } = req.body;

  // Kiểm tra tính duy nhất của topicType và level
  const existingLevel = await Level.findOne({ topicType, level });
  if (existingLevel) {
    return res.status(400).json({
      success: false,
      message: "Đã tồn tại level với cùng topicType và level",
    });
  }

  // Tạo một level mới dựa trên dữ liệu từ req.body
  const newLevel = await Level.create({ topicType,title, level });

  if (newLevel) {
    res.status(201).json({
      success: true,
      message: "Level đã được tạo thành công",
      data: newLevel,
    });
  } else {
    res.status(400).json({
      success: false,
      message: "Không thể tạo Level",
    });
  }
});
const createMultiple = asyncHandler(async (req, res) => {
  const levels = req.body;

  // Kiểm tra tính hợp lệ của từng level
  for (const levelData of levels) {
    const { topicType, level } = levelData;

    // Kiểm tra tính duy nhất của topicType và level
    const existingLevel = await Level.findOne({ topicType, level });
    if (existingLevel) {
      return res.status(400).json({
        success: false,
        message: `Đã tồn tại level với cùng topicType: ${topicType} và level: ${level}`,
      });
    }
  }

  // Tạo các level mới
  const newLevels = await Level.create(levels);

  if (newLevels) {
    res.status(201).json({
      success: true,
      message: "Các level đã được tạo thành công",
      data: newLevels,
    });
  } else {
    res.status(400).json({
      success: false,
      message: "Không thể tạo các level",
    });
  }
});
module.exports = {
  create,
  createMultiple
};
