abstract class ResetPasswordUseCase {
  Future<bool> updatePassword(String code, String password);
}
