abstract class EmailInputRepository {
  Future<bool> checkMail(String email);
  Future<bool> SendMail(String recipientEmail, String otp);
}
