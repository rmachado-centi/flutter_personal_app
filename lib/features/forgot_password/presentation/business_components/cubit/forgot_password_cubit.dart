import 'package:app/core/blocs/application_state.dart';
import 'package:app/features/forgot_password/domain/use_cases/forgot_password_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ApplicationState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  ForgotPasswordCubit({required this.forgotPasswordUseCase})
      : super(const ForgotPasswordInitialState());

  void sendPasswordResetEmail(String email) async {
    try {
      final wasEmailSent =
          await forgotPasswordUseCase.sendPasswordResetEmail(email);
      emit(ForgotPasswordEmailSentState(emailSentStatus: wasEmailSent));
    } catch (e) {
      emit(const ForgotPasswordErrorState(message: 'Error sending email'));
    }
  }
}
