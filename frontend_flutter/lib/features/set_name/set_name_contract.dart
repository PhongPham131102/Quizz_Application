abstract class SetNameContract {
  Future<void> settoken(String value);
  Future<void> setuid(String value);
  void setvalidateName(String _validateName);
  void setisloading(bool _isloading);
  void showDialog(String message);
  void pushHomeScreen();
}
