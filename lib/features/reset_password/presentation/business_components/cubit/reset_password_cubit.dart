import 'package:app/core/blocs/application_state.dart';
import 'package:app/features/reset_password/domain/use_cases/reset_password_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ApplicationState> {
  final ResetPasswordUseCase resetPasswordUseCase;
  ResetPasswordCubit({required this.resetPasswordUseCase})
      : super(const ResetPasswordInitialState());

  void updatePassword(String code, String password) async {
    try {
      await resetPasswordUseCase.updatePassword(code, password);
      emit(const ResetPasswordSuccessState());
    } catch (e) {
      emit(const ResetPasswordErrorState(message: 'Error updating password'));
    }
  }
}
