

abstract class ChangePasswordRepository {
  Future<bool> changePassword(String currentPassword, String newPassword);
}
