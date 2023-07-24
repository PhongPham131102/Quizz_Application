import 'package:flutter/cupertino.dart';
import 'package:frontend_flutter/repository/forgetpassword/email_input/get_email_input_contract.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class GetEmailInputRepository implements EmailInputRepository {
  Future<bool> checkMail(String email) async {
    var response = await http.post(Uri.parse('$baseUrl/users/checkMail'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
        }));
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  Future<bool> SendMail(String recipientEmail, String otp) async {
    String username = 'tracnghiemlaptrinhcaothang@gmail.com';
    String password = 'cjbckrgapzavlzjr';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Trắc Nghiệm Lập Trình')
      ..recipients.add(recipientEmail)
      ..subject = 'Mã khôi phục tài khoản Trắc Nghiệm Lập Trình của bạn'
      ..html ='''<div style="display: flex; justify-content: center; align-items: center; height: 100vh;">
        <form style="min-width: 200px; padding: 20px;">
            <div style="display: flex; margin: 0 auto; justify-content: center;">
             </div>
            <div style="padding-top: 20px;">
                <p style="color: #1E1E1E; font-size: 20px; font-style: normal; font-weight: 400; padding-bottom: 30px;">
                    Chúng tôi đã nhận được yêu cầu đặt lại Mật khẩu của bạn.<br>
                    Nhập mã đặt lại mật khẩu sau đây:
                </p>
                <div>
                    <p  style="color: #1E1E1E; font-size:32px; font-weight: 700;">${otp}</p>
                </div>
                <p style="color: #1E1E1E; font-size: 20px; font-style: normal; font-weight: 400;">
                    Bạn đã không yêu cầu thay đổi này?<br>
                    Nếu bạn không yêu cầu mật khẩu mới, hãy cho chúng tôi biết:
                </p>
            </div>
            <div style="display: flex; justify-content: center; align-items: center; padding-top: 20px;">
                <hr>
                <div style="display: flex; flex-direction: column; align-items: center; color: #7E7A7A; font-size: 15px; font-weight: 400;">
                    <p style="color: #218806; font-size: 22px; font-weight: 700;">Trắc Nghiệm Lập Trình</p>
                    <p>@PM20C, 65 Huỳnh Thúc Kháng, Quận 1, Tp.Hồ Chí Minh</p>
                    <p>Thư này được gửi đến ${recipientEmail}.</p>
                    <p>Để bảo vệ tài khoản của bạn, vui lòng không chuyển tiếp email này.</p>
                </div>
            </div>
        </form>
    </div>''';   try {
       debugPrint(message.toString());
      await send(message, smtpServer);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
