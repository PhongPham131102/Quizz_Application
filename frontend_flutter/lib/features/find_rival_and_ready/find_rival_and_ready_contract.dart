import 'package:frontend_flutter/models/Profile.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class FindRivalAndReadyContract {
  IO.Socket getSocket();
  setFinding(bool _finding);
  setrivalProfile(Profile _rivalProfile);
  setTime(int _time);
  setyouReady(bool _youReady);
  bool getyouready();
  String getroomId();
  setRoomId(String _roomId);
  outBattle();
  pushBattle();
}
