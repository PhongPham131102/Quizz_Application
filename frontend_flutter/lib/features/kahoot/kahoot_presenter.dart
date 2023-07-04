// ignore_for_file: unused_field

import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/kahoot/kahoot_contract.dart';
import 'package:frontend_flutter/repository/kahoot/get_fill_code_room_contract.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constants.dart';
class KahootPresenter{
    KahootContract _view;
    late KahootRepository _repository;
    
    KahootPresenter(this._view)
    {
      _repository=Injector().KahootRepository;
    }
      IO.Socket socket =
      IO.io('${baseUrl.replaceAll("/api", "")}', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });
  String room="";
  initSocket()
  {
  socket.on("join", (data) {
    print(data);
  });
  }
  sendCodeRoom(String _room)
  {
    room=_room;
    _view.setisloading(true);
         socket.on("checkRoom$uid", (data) {
      _view.setisloading(false);
      if(data["exit"] as bool==true)
      {
        _view.setHaveRoom();
      }else{
        _view.setvalidateName("không tồn tại mã phòng này.");
      }
      socket.off("checkRoom$uid");
    });
     socket.emit("checkRoom", {"uid": uid,"codeRoom":_room});
  }
    sendName(String name)
  {
         socket.on("testRoom${room}", (data) {
     print(data);
    });
     socket.emit("testRoom1", {"uid": uid,"name":name,"event":"join"});
  }
}