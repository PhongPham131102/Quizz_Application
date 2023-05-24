import 'package:frontend_flutter/repository/change_password/get_change_password_contract.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;

class GetChangePasswordRepository implements ChangePasswordRepository {
  @override
  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    var response =
        await http.post(Uri.parse('$baseUrl/users/changepassword'), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    }, body: {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
