abstract class LoginContract {
  Future<void> settoken(String value);
  Future<void> setuid(String value);
  void pushInfor(String message);
  void login();
  void setIsLoading(bool _isloading);
  void pushHomeScreen();
}
