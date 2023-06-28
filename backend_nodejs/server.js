const express = require("express");
var path = require("path");
const connectDb = require("./config/mongoodbConnection");
const Match = require("./models/matchModel");
const Question = require("./models/questionModel");
const detailUserMath = require("./models/detailUserMatchModel");
const errorHandler = require("./middleware/errorHandle");

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
app.set("views", path.join(__dirname, "views"));
app.use(express.static(path.join(__dirname, "public")));
app.use("/api/users", require("./routers/userRouters"));
app.use("/api/profiles", require("./routers/userProfileRouters"));
app.use("/api/questions", require("./routers/questionRouters"));
app.use("/api/items", require("./routers/itemRouters"));
app.use("/api/usersitems", require("./routers/userItemRouters"));
app.use("/api/userlevel", require("./routers/userLevelRouters"));
app.use("/api/match", require("./routers/matchRouters"));
app.use("/api/level", require("./routers/levelRouters"));
app.use("/api/usertopic", require("./routers/usertopicRouters"));
app.use("/api/detailusermatch", require("./routers/detailUserMatchRouters"));
app.use("/api/muster", require("./routers/musterRouters"));
app.use("/api/feedback", require("./routers/feedBackRouters"));
app.use("/api/testtheme", require("./routers/testThemeRouters"));
app.use(errorHandler);
app.use("/", require("./routers/index"));
//app.use("/", require("./routers/users"));
const { Server } = require("socket.io");
let io = new Server(server);
// app.get("/", (req, res) => {
//   res.sendFile(__dirname + "/index.html");
// });

function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
}
let roomSql = [];
let roomCss = [];
let roomHtml = [];
let roomCplusplus = [];
// Biến cờ theo dõi trạng thái của các phòng nếu có người chơi thoát phòng thì hủy countdown phòng đồng thời thông báo cho người chơi còn lại
let roomFlags = {};
// theo dõi trạng thái sẵn sàng của 2 người chơi nếu cả 2 đã sẵn sàng thì chuyển sang màn hình chơi
let readyRoom = {};
let matchs = {};
io.on("connection", (socket) => {
    socket.on("resume", async(data) => {
        console.log("have people");
        let uid = data.uid;
        let match = Object.values(matchs).find(
            (m) => m.player1.includes(uid) || m.player2.includes(uid)
        );

        if (match) {
            console.log("have match");
            let rival = await UserProfile.findOne({
                uid: match.player1.includes(uid) ? match.player2 : match.player1,
            });
            console.log(matchs[match.room].score2 + " " + matchs[match.room].score1);
            io.emit(`resume${uid}`, {
                rival: rival,
                idRoom: match.room,
                topic: match.topic,
                questions: match.questions,
                rivalscore: match.player1.includes(uid) ?
                    matchs[match.room].score2 : matchs[match.room].score1,
                yourscore: match.player1.includes(uid) ?
                    matchs[match.room].score1 : matchs[match.room].score2,
            });
        }
    });
    socket.on("Match", async(data) => {
        if (data.roomid in matchs) {
            if (data.uid == matchs[data.roomid].player1) {
                matchs[data.roomid].score1 += data.score;
                matchs[data.roomid].answer1.push({
                    index: data.index,
                    selectedIndex: data.selectedIndex,
                    idAnswer: data.idAnswer,
                });

                io.emit(`Match${data.roomid}`, data);
            } else if (data.uid == matchs[data.roomid].player2) {
                matchs[data.roomid].score2 += data.score;
                matchs[data.roomid].answer2.push({
                    index: data.index,
                    selectedIndex: data.selectedIndex,
                    idAnswer: data.idAnswer,
                });
                io.emit(`Match${data.roomid}`, data);
            }
        }
    });
    socket.on("OutRoomcplusplus", async(data) => {
        console.log(`người chơi: ${data.uid} rời phòng`);
        roomCplusplus.pop(data.uid);
        if (data.roomid in roomFlags) {
            roomFlags[data.roomid] = false; // Đặt giá trị biến cờ của phòng thành false
        }
    });
    socket.on("OutRoomcss", async(data) => {
        console.log(`người chơi: ${data.uid} rời phòng`);
        roomCss.pop(data.uid);
        if (data.roomid in roomFlags) {
            roomFlags[data.roomid] = false; // Đặt giá trị biến cờ của phòng thành false
        }
    });
    socket.on("OutRoomhtml", async(data) => {
        console.log(`người chơi: ${data.uid} rời phòng`);
        roomHtml.pop(data.uid);
        if (data.roomid in roomFlags) {
            roomFlags[data.roomid] = false; // Đặt giá trị biến cờ của phòng thành false
        }
    });
    socket.on("OutRoomsql", async(data) => {
        console.log(`người chơi: ${data.uid} rời phòng`);
        roomSql.pop(data.uid);
        if (data.roomid in roomFlags) {
            roomFlags[data.roomid] = false; // Đặt giá trị biến cờ của phòng thành false
        }
    });
    socket.on("Roomcplusplus", async(data) => {
        roomCplusplus.push(data.uid);
        console.log(roomCplusplus);
        if (roomCplusplus.length === 2) {
            const player1 = roomCplusplus.shift();
            const player2 = roomCplusplus.shift();
            if (player1 == player2) {
                roomCplusplus.push(data.uid);
            } else {
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
        }
    });
    socket.on("Roomcss", async(data) => {
        roomCss.push(data.uid);
        console.log(roomCss);
        if (roomCss.length === 2) {
            const player1 = roomCss.shift();
            const player2 = roomCss.shift();
            if (player1 == player2) {
                roomCss.push(data.uid);
            } else {
                console.log(`roomCss running on :${player1} ${player2}`);
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
                    topic: "css",
                };
                Countdown(roomid);
            }
        }
    });
    socket.on("Roomhtml", async(data) => {
        roomHtml.push(data.uid);
        console.log(roomHtml);
        if (roomHtml.length === 2) {
            const player1 = roomHtml.shift();
            const player2 = roomHtml.shift();
            if (player1 == player2) {
                roomHtml.push(data.uid);
            } else {
                console.log(`roomHtml running on :${player1} ${player2}`);
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
                    topic: "html",
                };
                Countdown(roomid);
            }
        }
    });
    socket.on("Roomsql", async(data) => {
        roomSql.push(data.uid);
        console.log(roomSql);
        if (roomSql.length === 2) {
            const player1 = roomSql.shift();
            const player2 = roomSql.shift();
            if (player1 == player2) {
                roomSql.push(data.uid);
            } else {
                console.log(`roomSql running on :${player1} ${player2}`);
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
                    topic: "sql",
                };
                Countdown(roomid);
            }
        }
    });
    socket.on("Ready", async(data) => {
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
        SendQuestionAndTime(roomid, topic);
    }
}

function GetQuesion(topic) {
    return Question.find({ typeLanguage: topic }).limit(5);
}
async function SendQuestionAndTime(room, topic) {
    let questions = await GetQuesion(topic);
    io.emit(`Questions${room}`, { questions: questions });

    matchs[room] = {
        room: room,
        player1: readyRoom[room].player1,
        player2: readyRoom[room].player2,
        questions: questions,
        score1: 0,
        score2: 0,
        answer1: [],
        answer2: [],
        topic: readyRoom[room].topic,
    };
    delete readyRoom[room];
    for (let i = 0; i < 5; i++) {
        for (let j = 20; j >= 0; j--) {
            await sleep(1000);
            io.emit(`TimerRoom${room}`, { time: j, index: i });
            //trường hợp người dùng mới vô phòng chưa nhận được bộ câu hỏi thì 10 giây đầu câu hỏi 1 có thể gửi lại câu hỏi
            if (i == 0) {
                io.emit(`Questions${room}`, { questions: questions });
            }
            if (
                matchs[room].answer1.some((answer) => answer.index === i) &&
                matchs[room].answer2.some((answer) => answer.index === i)
            ) {
                break;
            }
        }
        if (i == 4) {
            let match = await Match.create({
                room: matchs[room].room,
                player1: matchs[room].player1,
                player2: matchs[room].player2,
                questions: matchs[room].questions,
                score1: matchs[room].score1,
                score2: matchs[room].score2,
                answer1: matchs[room].answer1,
                answer2: matchs[room].answer2,
                topic: matchs[room].topic,
                winner: matchs[room].score1 === matchs[room].score2 ?
                    "" : matchs[room].score1 > matchs[room].score2 ?
                    matchs[room].player1 : matchs[room].player2,
            });
            io.emit(`Result${room}`, { match: match });
            if (match.winner === "") {
                console.log("Hòa");
                const player1 = await detailUserMath.findOne({ uid: match.player1 });
                const player2 = await detailUserMath.findOne({ uid: match.player2 });

                if (match.topic === "css") {
                    player1.numOfMatchCss += 1;
                    player1.numOfWinMatchCss += 1;
                    player1.save();

                    player2.numOfMatchCss += 1;
                    player2.numOfWinMatchCss += 1;
                    player2.save();
                } else if (match.topic === "c++") {
                    player1.numOfMatchCPlusPlus += 1;
                    player1.numOfWinMatchCPlusPlus += 1;
                    player1.save();

                    player2.numOfMatchCPlusPlus += 1;
                    player2.numOfWinMatchCPlusPlus += 1;
                    player2.save();
                } else if (match.topic === "html") {
                    player1.numOfMatchHtml += 1;
                    player1.numOfWinMatchHtml += 1;
                    player1.save();

                    player2.numOfMatchHtml += 1;
                    player2.numOfWinMatchHtml += 1;
                    player2.save();
                } else if (match.topic === "sql") {
                    player1.numOfMatchSql += 1;
                    player1.numOfWinMatchSql += 1;
                    player1.save();

                    player2.numOfMatchSql += 1;
                    player2.numOfWinMatchSql += 1;
                    player2.save();
                }
            } else if (match.winner !== "") {
                if (match.winner === match.player1) {
                    let profile = await UserProfile.findOne({ uid: match.player1 });
                    profile.star += 1;
                    await profile.save();

                    let profile2 = await UserProfile.findOne({ uid: match.player2 });
                    if (profile2.star > 0) {
                        profile2.star -= 1;
                        await profile2.save();
                    }
                    console.log("user1 :" + profile.uid);
                    console.log("user2 :" + profile2.uid);
                    io.emit(`profile${profile.uid}`, { profile: profile });
                    io.emit(`profile${profile2.uid}`, { profile: profile2 });
                    const player1 = await detailUserMath.findOne({ uid: match.player1 });
                    const player2 = await detailUserMath.findOne({ uid: match.player2 });

                    if (match.topic === "css") {
                        player1.numOfMatchCss += 1;
                        player1.numOfWinMatchCss += 1;
                        player1.save();

                        player2.numOfMatchCss += 1;
                        player2.save();
                    } else if (match.topic === "c++") {
                        player1.numOfMatchCPlusPlus += 1;
                        player1.numOfWinMatchCPlusPlus += 1;
                        player1.save();

                        player2.numOfMatchCPlusPlus += 1;
                        player2.save();
                    } else if (match.topic === "html") {
                        player1.numOfMatchHtml += 1;
                        player1.numOfWinMatchHtml += 1;
                        player1.save();

                        player2.numOfMatchHtml += 1;
                        player2.save();
                    } else if (match.topic === "sql") {
                        player1.numOfMatchSql += 1;
                        player1.numOfWinMatchSql += 1;
                        player1.save();

                        player2.numOfMatchSql += 1;
                        player2.save();
                    }
                } else {
                    let profile = await UserProfile.findOne({ uid: match.player2 });
                    profile.star += 1;
                    await profile.save();

                    let profile2 = await UserProfile.findOne({ uid: match.player1 });
                    if (profile2.star > 0) {
                        profile2.star -= 1;
                        await profile2.save();
                    }
                    console.log("user1 :" + profile.uid);
                    console.log("user2 :" + profile2.uid);
                    io.emit(`profile${profile.uid}`, { profile: profile });
                    io.emit(`profile${profile2.uid}`, { profile: profile2 });
                    const player1 = await detailUserMath.findOne({ uid: match.player1 });
                    const player2 = await detailUserMath.findOne({ uid: match.player2 });

                    if (match.topic === "css") {
                        player1.numOfMatchCss += 1;
                        player1.save();

                        player2.numOfMatchCss += 1;
                        player2.numOfWinMatchCss += 1;
                        player2.save();
                    } else if (match.topic === "c++") {
                        player1.numOfMatchCPlusPlus += 1;
                        player1.save();

                        player2.numOfMatchCPlusPlus += 1;
                        player2.numOfWinMatchCPlusPlus += 1;
                        player2.save();
                    } else if (match.topic === "html") {
                        player1.numOfMatchHtml += 1;
                        player1.save();

                        player2.numOfMatchHtml += 1;
                        player2.numOfWinMatchHtml += 1;
                        player2.save();
                    } else if (match.topic === "sql") {
                        player1.numOfMatchSql += 1;
                        player1.save();

                        player2.numOfMatchSql += 1;
                        player2.numOfWinMatchSql += 1;
                        player2.save();
                    }
                }
            }
            delete matchs[room];
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
    for (let i = 30; i >= 0; i--) {
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