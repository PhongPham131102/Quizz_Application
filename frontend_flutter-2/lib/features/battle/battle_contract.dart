import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../models/Question.dart';
abstract class BattleContract {
  IO.Socket getSocket();
  setTime(int _time);
  setIndex(int _index);
  int getIndex();
  setListQuestion(List<Question> _questions);
  setYouAnswered(bool _youAnswered);
  setyourSelectedAnswerIndex( _yourSelectedAnswerIndex);
  setRivalSelectedAnswerIndex( _rivalSelectedAnswerIndex);
  setRivalScore(int _rivalScore);
  setYourScore(int _yourScore);
}
