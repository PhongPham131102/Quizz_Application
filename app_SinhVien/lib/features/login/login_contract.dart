abstract class LoginContract {
  Future<void> settoken(String value);
  Future<void> setuid(String value);
  void set_token(String value);
  void set_uid(String value);
  void pushInfor(String message);
  void login();
  void setIsLoading(bool _isloading);
  void pushPickCharacterScreen();
  void pushSetNameScreen();
  void pushHomeScreen();
}
