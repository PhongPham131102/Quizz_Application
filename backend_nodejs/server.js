const express = require("express");
const connectDb = require("./config/mongoodbConnection");
const errorHandler = require("./middleware/errorHandle");
const app = express();
const http = require("http");
const server = http.createServer(app);
const dotenv = require("dotenv").config();
connectDb();
const port = process.env.PORT || 5000;
app.use(express.json()); // đọc được json từ client gửi lên
app.use((req, res, next) => {
  req.io = io;
  return next();
});
app.use("/api/users", require("./routers/userRouters"));
app.use("/api/profiles", require("./routers/userProfileRouters"));
app.use(errorHandler);
const { Server } = require("socket.io");
let io = new Server(server);
app.get("/", (req, res) => {
  res.sendFile(__dirname + "/index.html");
});
io.on("connection", (socket) => {
  socket.on("on-chat", (data) => {
    console.log(data);
    io.emit("user-chat", data);
  });
});

server.listen(port, () => {
  console.log(`Server running on port : ${port}`);
});

