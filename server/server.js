const express = require("express");
var path = require("path");
const connectDb = require("./config/mongoodbConnection");
const Match = require("./models/matchModel");
const short = require("short-uuid");
const Question = require("./models/questionModel");
const detailUserMath = require("./models/detailUserMatchModel");
const Test = require("./models/testModel");
const QuestionTheme = require("./models/questionThemeModel");
const errorHandler = require("./middleware/errorHandle");
var cookieParser = require("cookie-parser");
const app = express();
const http = require("http");
const server = http.createServer(app);
const dotenv = require("dotenv").config();
const UserProfile = require("./models/userProfileModel");
connectDb();
const port = process.env.PORT || 5000;
app.set("view engine", "ejs");
app.use(express.json({ limit: "10mb" }));
app.use(express.urlencoded({ limit: "10mb", extended: true }));
app.use(cookieParser());
app.use(express.json());
app.use((req, res, next) => {
    req.io = io;
    return next();
});
app.set("views", path.join(__dirname, "views"));
app.use(express.static(path.join(__dirname, "public")));
app.use("/api/users", require("./routers/userRouters"));
app.use("/api/userstemporary", require("./routers/userTemporaryRouters"));
app.use("/api/profiles", require("./routers/userProfileRouters"));
app.use("/api/questions", require("./routers/questionRouters"));
app.use("/api/questionthemes", require("./routers/questionThemeRouters"));
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
app.use("/api/test", require("./routers/testRouters"));
app.use("/email", require("./routers/emailRouter"));
app.use("/", require("./routers/index"));
app.use("/admin", require("./routers/adminRouter"));
app.use(errorHandler);
app.use(function(req, res, next) {
    res.render("error");
});
const { Server } = require("socket.io");
let io = new Server(server);

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
//xử lý dữ liệu trong room của 2 người chơi
let matchs = {};
//lưu trữ biến phòng kiểm tra
let testRoom = [];

function generateRandomNumberString(length) {
    var result = "";
    var characters = "0123456789";

    for (var i = 0; i < length; i++) {
        var randomIndex = Math.floor(Math.random() * characters.length);
        result += characters.charAt(randomIndex);
    }

    return result;
}
io.on("connection", (socket) => {
    socket.on("testRoomStudent", async(data) => {
        console.log("outroom");
        if (data.event == "outroom") {
            console.log("outroom");
            io.emit(`outroom${data.testRoom}`, {
                event: data.event,
            });
        }
        if (data.event == "showboard") {
            io.emit(`testRoomStudent${data.testRoom}`, {
                event: data.event,
            });
        }
        if (data.event == "summary") {
            io.emit(`testRoomStudent${data.testRoom}`, {
                event: data.event,
            });
        }
        if (data.event == "showQuestion") {
            io.emit(`testRoomStudent${data.testRoom}`, {
                event: data.event,
                indexQuestion: data.indexQuestion,
            });
        }
        if (data.event == "time") {
            io.emit(`testRoomStudent${data.testRoom}`, {
                event: data.event,
                time: data.time,
            });
        }
        if (data.event == "coutdown") {
            io.emit(`testRoomStudent${data.testRoom}`, {
                event: data.event,
            });
        }
        if (data.event == "valueCoutdown") {
            io.emit(`testRoomStudent${data.testRoom}`, {
                event: data.event,
                countdown: data.countdown,
            });
        }
    });
    socket.on("testRoom", async(data) => {
        if (data.event == "join") {
            io.emit(`testRoom${data.roomCode}`, {
                event: data.event,
                uid: data.uid,
                name: data.name,
            });
        }
        if (data.event == "outroom") {
            io.emit(`testRoom${data.roomCode}`, {
                event: data.event,
                uid: data.uid,
            });
        }
    });
    socket.on("RoomPlayer", async(data) => {
        io.emit(`RoomPlayer${data.uid}`, {
            message: data.message,
        });
    });
    socket.on("join", async(data) => {
        if (data["isJoin"] == true) {
            var idPost = data["idPost"];
            let test = await Test.findOne({ _id: idPost });
            let listQuestions = [];
            for (const element of test.listQuestions) {
                const question = await QuestionTheme.findOne({ _id: element });
                listQuestions.push(question.toObject());
            }
            console.log(idPost);
            io.emit(`join${data.uid}`, {
                isJoin: data.isJoin,
                listQuestions: listQuestions,
            });
        } else {
            io.emit(`join${data.uid}`, {
                isJoin: data.isJoin,
            });
        }
    });
    socket.on("checkRoom", async(data) => {
        var codeRoom = data.codeRoom;
        if (testRoom.includes(codeRoom)) {
            io.emit(`checkRoom${data.uid}`, {
                exit: true,
            });
        } else {
            io.emit(`checkRoom${data.uid}`, {
                exit: false,
            });
        }
    });
    socket.on("sendToTeacher", async(data) => {
        io.emit(`testRoom${data.codeRoom}`, {
            uid: data.uid,
            score: data.score,
            index: data.index,
            event: data.event,
        });
    });
    socket.on("getroom", async(data) => {
        console.log(data);
        var randomNumber = generateRandomNumberString(6);
        let isDuplicate = true;
        let uid = data.uid;

        while (isDuplicate) {
            randomNumber = generateRandomNumberString(6);

            if (!testRoom.includes(randomNumber)) {
                isDuplicate = false;
                testRoom.push(randomNumber);
            }
        }
        var idPost = data["idPost"];
        if (idPost) {
            let test = await Test.findOne({ _id: idPost });
            let listQuestions = [];
            for (const element of test.listQuestions) {
                const question = await QuestionTheme.findOne({ _id: element });
                listQuestions.push(question.toObject());
            }
            io.emit(`testRoom${uid}`, {
                testRoom: randomNumber,
                listQuestions: listQuestions,
            });
        } else {
            io.emit(`testRoom${uid}`, {
                testRoom: randomNumber,
                // listQuestions: listQuestions,
            });
        }
        // for (i = 0; i < 20; i++) {
        //   socket.emit(`join`, {
        //     isJoin: true,
        //   });
        // }
        // for (i = 0; i < 20; i++) {
        //     await sleep(200);
        //     io.emit(`testRoom${randomNumber}`, {
        //         uid: i,
        //         name: i,
        //         testRoom: randomNumber,
        //         event: "join",
        //     });
        // }
    });
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
                if (data.usingDetroyChip) {
                    if (data.score > 0) {
                        matchs[data.roomid].score1 += data.score;
                        matchs[data.roomid].answer1.push({
                            index: data.index,
                            selectedIndex: data.selectedIndex,
                            idAnswer: data.idAnswer,
                        });
                        var subtracScore = matchs[data.roomid].score2 - data.score;
                        console.log(subtracScore);
                        if (subtracScore < 0) {
                            matchs[data.roomid].score2 = 0;
                            io.emit(`DetroyChip${data.roomid}`, data);
                        } else {
                            matchs[data.roomid].score2 = subtracScore;
                            io.emit(`DetroyChip${data.roomid}`, data);
                        }
                    } else {
                        matchs[data.roomid].score2 += data.scoreIfCorrect;
                        matchs[data.roomid].answer1.push({
                            index: data.index,
                            selectedIndex: data.selectedIndex,
                            idAnswer: data.idAnswer,
                        });
                        var subtracScore = matchs[data.roomid].score1 - data.scoreIfCorrect;
                        if (subtracScore < 0) {
                            matchs[data.roomid].score1 = 0;

                            io.emit(`DetroyChip${data.roomid}`, data);
                        } else {
                            matchs[data.roomid].score1 = subtracScore;
                            io.emit(`DetroyChip${data.roomid}`, data);
                        }
                    }
                } else {
                    matchs[data.roomid].score1 += data.score;
                    matchs[data.roomid].answer1.push({
                        index: data.index,
                        selectedIndex: data.selectedIndex,
                        idAnswer: data.idAnswer,
                    });
                    io.emit(`Match${data.roomid}`, data);
                }
            } else if (data.uid == matchs[data.roomid].player2) {
                if (data.usingDetroyChip) {
                    if (data.score > 0) {
                        matchs[data.roomid].score2 += data.score;
                        matchs[data.roomid].answer2.push({
                            index: data.index,
                            selectedIndex: data.selectedIndex,
                            idAnswer: data.idAnswer,
                        });
                        var subtracScore = matchs[data.roomid].score1 - data.score;
                        console.log(subtracScore);
                        if (subtracScore < 0) {
                            matchs[data.roomid].score1 = 0;
                            io.emit(`DetroyChip${data.roomid}`, data);
                        } else {
                            matchs[data.roomid].score1 = subtracScore;
                            io.emit(`DetroyChip${data.roomid}`, data);
                        }
                    } else {
                        matchs[data.roomid].score1 += data.scoreIfCorrect;
                        matchs[data.roomid].answer2.push({
                            index: data.index,
                            selectedIndex: data.selectedIndex,
                            idAnswer: data.idAnswer,
                        });
                        var subtracScore = matchs[data.roomid].score2 - data.scoreIfCorrect;
                        if (subtracScore < 0) {
                            matchs[data.roomid].score2 = 0;
                            io.emit(`DetroyChip${data.roomid}`, data);
                        } else {
                            matchs[data.roomid].score1 = subtracScore;
                            io.emit(`DetroyChip${data.roomid}`, data);
                        }
                    }
                } else {
                    matchs[data.roomid].score2 += data.score;
                    matchs[data.roomid].answer2.push({
                        index: data.index,
                        selectedIndex: data.selectedIndex,
                        idAnswer: data.idAnswer,
                    });
                    io.emit(`Match${data.roomid}`, data);
                }
            }
        }
    });
    socket.on("CopyAnswer", async(data) => {
        io.emit(`CopyAnswer${data.roomid}`, data);
    });
    socket.on("SubtractTime", async(data) => {
        matchs[data.roomid].subtractTime = data.timeSubtract;
        matchs[data.roomid].isSubtractTime = true;
        io.emit(`SubtractTime${data.roomid}`, data);
    });
    socket.on("OutRoomcplusplus", async(data) => {
        console.log(roomCplusplus);
        console.log(`người chơi: ${data.uid} rời phòng`);
        if (roomCplusplus.includes(data.uid)) {
            roomCplusplus.pop(data.uid);
        }
        if (data.roomid in roomFlags) {
            roomFlags[data.roomid] = false; // Đặt giá trị biến cờ của phòng thành false
        }
    });
    socket.on("OutRoomcss", async(data) => {
        console.log(`người chơi: ${data.uid} rời phòng`);
        if (roomCss.includes(data.uid)) {
            roomCss.pop(data.uid);
        }
        if (data.roomid in roomFlags) {
            roomFlags[data.roomid] = false; // Đặt giá trị biến cờ của phòng thành false
        }
    });
    socket.on("OutRoomhtml", async(data) => {
        console.log(`người chơi: ${data.uid} rời phòng`);
        if (roomHtml.includes(data.uid)) {
            roomHtml.pop(data.uid);
        }
        if (data.roomid in roomFlags) {
            roomFlags[data.roomid] = false; // Đặt giá trị biến cờ của phòng thành false
        }
    });
    socket.on("OutRoomsql", async(data) => {
        console.log(`người chơi: ${data.uid} rời phòng`);
        if (roomSql.includes(data.uid)) {
            roomSql.pop(data.uid);
        }
        if (data.roomid in roomFlags) {
            roomFlags[data.roomid] = false; // Đặt giá trị biến cờ của phòng thành false
        }
    });
    socket.on("Roomcplusplus", async(data) => {
        roomCplusplus.push(data.uid);
        console.log(roomCplusplus);
        if (roomCplusplus.length >= 2) {
            const player2 = data.uid;
            const newPlayerProfile = await UserProfile.findOne({ uid: player2 });
            const newPlayerStar = newPlayerProfile.star;
            let player1 = null;
            for (let i = 0; i < roomCplusplus.length; i++) {
                const existingPlayerUid = roomCplusplus[i];
                if (existingPlayerUid == player2) {
                    continue;
                }
                const existingPlayerProfile = await UserProfile.findOne({
                    uid: existingPlayerUid,
                });
                const existingPlayerStar = existingPlayerProfile ?
                    existingPlayerProfile.star :
                    0;

                if (Math.abs(newPlayerStar - existingPlayerStar) < 8) {
                    player1 = existingPlayerUid;
                    break;
                }
            }
            if (player1 && player1 != player2) {
                roomCplusplus = roomCplusplus.filter(
                    (uid) => uid !== player2 && uid !== player1
                );
                console.log(`running on :${player1} ${player2}`);
                let roomid = short.generate();
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
        console.log(data.uid);
        roomCss.push(data.uid);
        console.log(roomCss);
        if (roomCss.length >= 2) {
            const player2 = data.uid;
            const newPlayerProfile = await UserProfile.findOne({ uid: player2 });
            const newPlayerStar = newPlayerProfile.star;
            let player1 = null;
            for (let i = 0; i < roomCss.length; i++) {
                const existingPlayerUid = roomCss[i];
                if (existingPlayerUid == player2) {
                    continue;
                }
                const existingPlayerProfile = await UserProfile.findOne({
                    uid: existingPlayerUid,
                });
                const existingPlayerStar = existingPlayerProfile ?
                    existingPlayerProfile.star :
                    0;

                if (Math.abs(newPlayerStar - existingPlayerStar) < 8) {
                    player1 = existingPlayerUid;
                    break;
                }
            }
            if (player1 && player1 != player2) {
                roomCss = roomCss.filter((uid) => uid !== player2 && uid !== player1);
                console.log(`roomCss running on :${player1} ${player2}`);
                let roomid = short.generate();
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
        if (roomHtml.length >= 2) {
            const player2 = data.uid;
            const newPlayerProfile = await UserProfile.findOne({ uid: player2 });
            const newPlayerStar = newPlayerProfile.star;
            let player1 = null;
            for (let i = 0; i < roomHtml.length; i++) {
                const existingPlayerUid = roomHtml[i];
                if (existingPlayerUid == player2) {
                    continue;
                }
                const existingPlayerProfile = await UserProfile.findOne({
                    uid: existingPlayerUid,
                });
                const existingPlayerStar = existingPlayerProfile ?
                    existingPlayerProfile.star :
                    0;

                if (Math.abs(newPlayerStar - existingPlayerStar) < 8) {
                    player1 = existingPlayerUid;
                    break;
                }
            }
            if (player1 && player1 != player2) {
                roomHtml = roomHtml.filter((uid) => uid !== player2 && uid !== player1);
                console.log(`roomHtml running on :${player1} ${player2}`);
                let roomid = short.generate();
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
        if (roomSql.length >= 2) {
            const player2 = data.uid;
            const newPlayerProfile = await UserProfile.findOne({ uid: player2 });
            const newPlayerStar = newPlayerProfile.star;
            let player1 = null;
            for (let i = 0; i < roomSql.length; i++) {
                const existingPlayerUid = roomSql[i];
                if (existingPlayerUid == player2) {
                    continue;
                }
                const existingPlayerProfile = await UserProfile.findOne({
                    uid: existingPlayerUid,
                });
                const existingPlayerStar = existingPlayerProfile ?
                    existingPlayerProfile.star :
                    0;

                if (Math.abs(newPlayerStar - existingPlayerStar) < 8) {
                    player1 = existingPlayerUid;
                    break;
                }
            }
            if (player1 && player1 != player2) {
                roomSql = roomSql.filter((uid) => uid !== player2 && uid !== player1);
                console.log(`roomSql running on :${player1} ${player2}`);
                let roomid = short.generate();
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

function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min);
}

function GetQuesion(topic) {
    return Question.find({ typeLanguage: topic }).limit(5);
}
async function SendQuestionAndTime(room, topic) {
    let questions = await GetQuesion(topic);

    var x2Score = randomIntFromInterval(0, 4);
    console.log(x2Score);
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
        isSubtractTime: false,
        subtractTime: 0,
    };
    io.emit(`Questions${room}`, { questions: questions, x2Score: x2Score });
    delete readyRoom[room];
    for (let i = 0; i < 5; i++) {
        for (let j = questions[i].time; j >= 0; j--) {
            if (matchs[room].isSubtractTime) {
                j = matchs[room].subtractTime;
                matchs[room].isSubtractTime = false;
                matchs[room].subtractTime = 0;
                if (j == 0) {
                    break;
                }
            }
            await sleep(1000);
            io.emit(`TimerRoom${room}`, { time: j, index: i });
            //trường hợp người dùng mới vô phòng chưa nhận được bộ câu hỏi thì 10 giây đầu câu hỏi 1 có thể gửi lại câu hỏi
            io.emit(`Questions${room}`, { questions: questions, x2Score: x2Score });
            if (
                matchs[room].answer1.some((answer) => answer.index == i) &&
                matchs[room].answer2.some((answer) => answer.index == i)
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