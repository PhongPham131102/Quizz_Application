import 'package:front_end_teacher/models/QuestionTheme.dart';

abstract class KahootContract {
  setIdRoom(String idRoom);
  getLockRoom();
  getHavePlayer();
  sethavePlayer(bool _havePlayer);
  incrementTotalAnswer();
  getTotalScore();
  int getIndexQuestion();
  setIndexQuestion(int index);
  incrementAnwer1();
  incrementAnwer2();
  incrementAnwer3();
  incrementPlayer();
  getCountPlayer();
  decrementCountPlayer();
  incrementAnwer4();
  resetAnswer();
  getListQuestion();
  setTime(int _time);
  getTypePost();
  setListQuestion(List<QuestionTheMe> questionList);
  setIsCoutdown();
  setisShowQuestion();
  setValueCoutdown(int i);
  setisShowBoad(bool _isShowBoard);
  setSkipQuestion(bool value);
  setIsSummary();
  SetsortedEntries( List<MapEntry<String, dynamic>> _sortedEntries);
}
