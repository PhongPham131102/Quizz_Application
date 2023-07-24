import '../../models/QuestionTheme.dart';

abstract class KahootContract {
  void setvalidateName(String _validateName);
  void setisloading(bool _isloading);
  void showDialog(String message, bool ispop);
  void setHaveRoom();
  setValueCoutDown(String value);
  RoomisSummanry(bool _isSummary);
  RoomisShowQuestion(bool _isShowQuestion,int _indexQuestion);
  RoomisShowCorrect(bool iisShowCorrect);
  RoomisCoutDown(bool _isCoutDown);
  RoomtisInRoom(bool _isInRoom);
  setRoom(_room);
  setListQuestion(List<QuestionTheMe> _listQuestionsTheme);
  setName(_name);
  setTime(int _time);
}
