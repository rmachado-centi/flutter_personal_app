import 'package:app/core/data/repositories/auth/auth_repository.dart';
import 'package:app/features/forgot_password/domain/use_cases/forgot_password_use_case.dart';

class ForgotPasswordUseCaseImpl implements ForgotPasswordUseCase {
  final AuthRepository _authRepository;

  ForgotPasswordUseCaseImpl(this._authRepository);

  @override
  Future<bool> sendPasswordResetEmail(String email) async =>
      await _authRepository.sendPasswordResetEmail(email);
}
