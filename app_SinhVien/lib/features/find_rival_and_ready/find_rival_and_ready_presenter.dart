import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/find_rival_and_ready/find_rival_and_ready_contract.dart';
import 'package:frontend_flutter/models/Profile.dart';
import 'package:frontend_flutter/repository/find_rival_and_ready/get_find_rival_and_ready_contract.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constants.dart';

class FindRivalAndReadyPresenter {
  FindRivalAndReadyContract _view;
  // ignore: unused_field
  late FindRivalAndReadyRepository _repository;
  FindRivalAndReadyPresenter(this._view) {
    _repository = Injector().FindRivalAndReadyRepository;
  }
  setprofile() {
    _view.setFinding(false);
  }

  FindRival(String topic) {
    IO.Socket socket = _view.getSocket();
    socket.emit("Room${topic}", {"uid": uid});
    socket.on("Room$uid", (data) {
      print("dữ liệu gửi đến Room$uid");
      _view.setrivalProfile(Profile.fromJson(data["proflie"]));
      _view.setFinding(false);
      _view.setRoomId(data["roomId"]);
      socket.off("Room$uid");
      CountDown(data["roomId"]);
    });
  }

  CountDown(String room) {
    IO.Socket socket = _view.getSocket();
    socket.on("GetReady$room", (data) {
      _view.pushBattle();
      socket.off("GetReady$room");
    });
    socket.on("Room$room", (data) {
      _view.setTime(data["time"] as int);
      if (data["time"] as int == 0) {
        
        Future.delayed(Duration(milliseconds: 1000), () {
          if (_view.getyouready()) {
            _view.resumeFinding();
          } else {
            _view.outBattle();
          }
        });
      }
    });
  }

  Ready() {
    String roomid = _view.getroomId();
    print("$uid:you ready:$roomid");

    IO.Socket socket = _view.getSocket();
    socket.emit("Ready", {"uid": uid, "roomid": roomid});
    _view.setyouReady(true);
  }
}
