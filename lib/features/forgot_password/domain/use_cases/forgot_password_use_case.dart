abstract class ForgotPasswordUseCase {
  Future<bool> sendPasswordResetEmail(String email);
}
