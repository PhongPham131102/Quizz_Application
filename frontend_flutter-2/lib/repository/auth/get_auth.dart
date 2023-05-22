import '../../constants.dart';
import 'get_auth_contract.dart';
import 'package:http/http.dart' as http;

class GetAuthRepository implements AuthRepository {
  @override
  Future<bool> checkToken(String token) async {
    var response = await http.get(Uri.parse('$baseUrl/users/checkToken'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}
