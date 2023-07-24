abstract class EmailInputContract{
  void setEmailCheck(String message);
  void setisLoading(bool _isLoading);
  void showSnackbar(String message);
  void pushOTPInputScreen(String otp);
}