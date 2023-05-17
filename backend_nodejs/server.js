const express = require("express");
const connectDb = require("./config/mongoodbConnection");
const errorHandler = require("./middleware/errorHandle");
const app = express();
const dotenv = require("dotenv").config();
connectDb();
const port = process.env.PORT || 5000;
app.use(express.json()); // đọc được json từ client gửi lên
app.use("/api/users", require("./routers/userRouters"));
app.use(errorHandler);
app.listen(port, () => {
  console.log(`Server running on port : ${port}`);
});
