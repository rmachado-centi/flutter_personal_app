import 'package:app/core/data/repositories/auth/auth_repository.dart';
import 'package:app/features/reset_password/domain/use_cases/reset_password_use_case.dart';

class ResetPasswordUseCaseImpl implements ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCaseImpl({required this.authRepository});

  @override
  Future<bool> updatePassword(String code, String password) {
    return authRepository.updatePassword(code, password);
  }
}
