abstract class PasswordInputContract
{
  void setvalidatePassWord(String _validatePassWord);
  void setvalidateCfPassWord(String _validateCfPassWord);
  void setpasswordVisible(bool _passwordVisible);
  void setcFPasswordVisible(bool _cFPasswordVisible);
  void setisloading(bool _isloading);
  void showDialogMessage(String message,bool isPop);
}