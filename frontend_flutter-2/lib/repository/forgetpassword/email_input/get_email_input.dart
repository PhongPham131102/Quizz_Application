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
      ..html =
          '<div class=""><div class="aHl"></div><div id=":nh" tabindex="-1"></div><div id=":n6" class="ii gt" jslog="20277; u014N:xr6bB; 1:WyIjdGhyZWFkLWY6MTc2MDY2NjQ2MjgxODAyNTgwMCIsbnVsbCxudWxsLG51bGwsbnVsbCxudWxsLG51bGwsbnVsbCxudWxsLG51bGwsbnVsbCxudWxsLG51bGwsW11d; 4:WyIjbXNnLWY6MTc2MDY2NjQ2MjgxODAyNTgwMCIsbnVsbCxbXV0."><div id=":n5" class="a3s aiL msg2242512709831621897"><u></u><div style="margin:0;padding:0" dir="ltr" bgcolor="#ffffff"><table border="0" cellspacing="0" cellpadding="0" align="center" id="m_2242512709831621897email_table" style="border-collapse:collapse"><tbody><tr><td id="m_2242512709831621897email_content" style="font-family:Helvetica Neue,Helvetica,Lucida Grande,tahoma,verdana,arial,sans-serif;background:#ffffff"><table border="0" width="100%" cellspacing="0" cellpadding="0" style="border-collapse:collapse"><tbody><tr><td height="20" style="line-height:20px" colspan="3">&nbsp;</td></tr><tr><td height="1" colspan="3" style="line-height:1px"><span style="color:#ffffff;font-size:1px;opacity:0">Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu Facebook của bạn.</span></td></tr><tr><td width="15" style="display:block;width:15px">&nbsp;&nbsp;&nbsp;</td><td><table border="0" width="100%" cellspacing="0" cellpadding="0" style="border-collapse:collapse"><tbody><tr><td height="4" style="line-height:4px">&nbsp;</td></tr><tr><td><span class="m_2242512709831621897mb_text" style="font-family:Helvetica Neue,Helvetica,Lucida Grande,tahoma,verdana,arial,sans-serif;font-size:16px;line-height:21px;color:#141823"><span style="font-size:15px"><p></p><div>Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu Trắc Nghiệm Lập Trình của bạn của bạn.</div>Nhập mã đặt lại mật khẩu sau đây:<p></p><table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse;width:max-content;margin-top:20px;margin-bottom:20px"><tbody><tr><td style="font-size:11px;font-family:LucidaGrande,tahoma,verdana,arial,sans-serif;padding:14px 32px 14px 32px;background-color:#f2f2f2;border-left:1px solid #ccc;border-right:1px solid #ccc;border-top:1px solid #ccc;border-bottom:1px solid #ccc;text-align:center;border-radius:7px;display:block;border:1px solid #1877f2;background:#e7f3ff"><span class="m_2242512709831621897mb_text" style="font-family:Helvetica Neue,Helvetica,Lucida Grande,tahoma,verdana,arial,sans-serif;font-size:16px;line-height:21px;color:#141823"><span style="font-size:17px;font-family:Roboto;font-weight:700;margin-left:0px;margin-right:0px">$otp</span></span></td></tr></tbody></table><table border="0" width="100%" cellspacing="0" cellpadding="0" style="border-collapse:collapse"></table><br>.</span></span></td></tr></tbody></table></td><td width="15" style="display:block;width:15px">&nbsp;&nbsp;&nbsp;</td></tr></tbody></table><span><img src="https://ci3.googleusercontent.com/proxy/f3FFr501Ue07BNSzYInRsDG7db5l03E42GMdUDWk6Pcmo5TWv2Vis5IQMTUtFF0APsLKGyYz9w5eXVayKOgp5idDHoI2-8cmD4BiI8cstWC8p4O6RZQK496MtMrgKfy5eoRjUTlJvqPSr_8IoWlPdLNWkQ=s0-d-e1-ft#https://www.facebook.com/email_open_log_pic.php?mid=5f72232e880bfG5b0495126f76G5f7227c7e8391G178" style="border:0;width:1px;height:1px" class="CToWUd" data-bit="iit"></span></td></tr></tbody></table></div><div class="yj6qo"></div><div class="adL"></div></div></div><div id=":nl" class="ii gt" style="display:none"><div id=":nm" class="a3s aiL "></div></div><div class="hi"></div></div>';
    try {
       debugPrint(message.toString());
      await send(message, smtpServer);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
