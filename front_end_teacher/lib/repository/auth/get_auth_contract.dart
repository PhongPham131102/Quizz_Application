import 'dart:async';

abstract class AuthRepository {
Future<bool> checkToken(String token);
}