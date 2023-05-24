const express = require("express");
const connectDb = require("./config/mongoodbConnection");
const errorHandler = require("./middleware/errorHandle");
const Question = require("./models/questionModel");
const app = express();
const http = require("http");
const server = http.createServer(app);
const dotenv = require("dotenv").config();
const UserProfile = require("./models/userProfileModel");
connectDb();
const port = process.env.PORT || 5000;
app.use(express.json()); // đọc được json từ client gửi lên
app.use((req, res, next) => {
  req.io = io;
  return next();
});
app.use("/api/users", require("./routers/userRouters"));
app.use("/api/profiles", require("./routers/userProfileRouters"));
app.use("/api/questions", require("./routers/questionRouters"));
app.use(errorHandler);
const { Server } = require("socket.io");
let io = new Server(server);
app.get("/", (req, res) => {
  res.sendFile(__dirname + "/index.html");
});
function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}
let roomSql = [];
let roomCss = [];
let roomHtml = [];
let roomCplusplus = [];
let roomFlags = {}; // Biến cờ theo dõi trạng thái của các phòng
let readyRoom = {};
io.on("connection", (socket) => {
  socket.on("OutRoomcplusplus", async (data) => {
    console.log(`user ${data.uid} out room`);
    roomCplusplus.pop(data.uid);
    if (data.roomid in roomFlags) {
      roomFlags[data.roomid] = false; // Đặt giá trị biến cờ của phòng thành false
    }
  });
  socket.on("Roomcplusplus", async (data) => {
    roomCplusplus.push(data.uid);
    console.log(roomCplusplus);
    if (roomCplusplus.length === 2) {
      const player1 = roomCplusplus.shift();
      const player2 = roomCplusplus.shift();
      roomCplusplus = [];
      console.log(`running on :${player1} ${player2}`);
      let roomid = player1 + player2;
      const usersProfile1 = await UserProfile.findOne({
        uid: player1,
      });
      const usersProfile2 = await UserProfile.findOne({
        uid: player2,
      });
      io.emit(`Room${player1}`, { proflie: usersProfile2, roomId: roomid });
      io.emit(`Room${player2}`, { proflie: usersProfile1, roomId: roomid });
      roomFlags[roomid] = true;
      readyRoom[roomid] = {
        roomid: roomid,
        player1: player1,
        player2: player2,
        ready1: false,
        ready2: false,
        topic: "c++",
      };
      Countdown(roomid);
    }
  });
  socket.on("Ready", async (data) => {
    console.log(data);
    let targetRoom = null;

    for (const roomId in readyRoom) {
      const room = readyRoom[roomId];
      if (room.roomid === data.roomid) {
        targetRoom = room;
        break;
      }
    }
    if (targetRoom != null) {
      if (data.uid == targetRoom.player1) {
        readyRoom[targetRoom.roomid].ready1 = true;
        GetReady(
          readyRoom[targetRoom.roomid].ready1,
          readyRoom[targetRoom.roomid].ready2,
          targetRoom.roomid,
          readyRoom[targetRoom.roomid].topic
        );
      } else if (data.uid == targetRoom.player2) {
        readyRoom[targetRoom.roomid].ready2 = true;
        GetReady(
          readyRoom[targetRoom.roomid].ready1,
          readyRoom[targetRoom.roomid].ready2,
          targetRoom.roomid,
          readyRoom[targetRoom.roomid].topic
        );
      }
    }
  });
});
function GetReady(ready1, ready2, roomid, topic) {
  if (ready1 && ready2) {
    io.emit(`GetReady${roomid}`, { ready: "all user have been ready" });
    roomFlags[roomid] = false;
    delete readyRoom[roomid];
    SendQuestionAndTime(roomid, topic);
  }
}
function GetQuesion(topic) {
  return Question.find({ typeLanguage: topic }).limit(5);
}
async function SendQuestionAndTime(room, topic) {
  let questions = await GetQuesion(topic);
  io.emit(`Questions${room}`, { questions: questions });
  for (let i = 0; i < 5; i++) {
    for (let j = 10; j >= 0; j--) {
      await sleep(1000);
      io.emit(`TimerRoom${room}`, { time: j, index: i });
    }
  }
}
let deleteFlags = (roomid) => {
  if (roomid in roomFlags) {
    console.log("đã xóa : " + roomid);
    delete roomFlags[roomid];
  }
};
async function Countdown(roomid) {
  for (let i = 15; i >= 0; i--) {
    if (!roomFlags[roomid]) {
      deleteFlags(roomid);
      io.emit(`Room${roomid}`, { time: 0 });
      console.log("stop sending coutdown");
      break;
    }
    io.emit(`Room${roomid}`, { time: i });
    await sleep(1000);
  }
  deleteFlags(roomid);
}

server.listen(port, () => {
  console.log(`Server running on port : ${port}`);
});
