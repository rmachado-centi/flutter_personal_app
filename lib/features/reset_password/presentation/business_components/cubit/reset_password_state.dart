part of 'reset_password_cubit.dart';

class ResetPasswordInitialState extends ApplicationState {
  const ResetPasswordInitialState();
}

class ResetPasswordSuccessState extends ApplicationState {
  const ResetPasswordSuccessState();
}

class ResetPasswordErrorState extends ApplicationState {
  final String message;
  const ResetPasswordErrorState({required this.message});
}
