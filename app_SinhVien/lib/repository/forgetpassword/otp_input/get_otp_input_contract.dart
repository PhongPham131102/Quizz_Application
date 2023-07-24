abstract class OTPInputRepository{
    Future<bool> SendMail(String recipientEmail, String otp);
}