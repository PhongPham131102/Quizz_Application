import 'package:front_end_teacher/models/QuestionTheme.dart';

abstract class KahootContract {
  setIdRoom(String idRoom);
  getLockRoom();
  getHavePlayer();
  sethavePlayer(bool _havePlayer);
  incrementTotalAnswer();
  getTotalScore();
  getIndexQuestion();
  incrementAnwer1();
  incrementAnwer2();
  incrementAnwer3();
  incrementPlayer();
  getCountPlayer();
  decrementCountPlayer();
  incrementAnwer4();
  setListQuestion(List<QuestionTheMe> questionList);
  setisShowBoad(bool _isShowBoard);
}
