part of 'forgot_password_cubit.dart';

class ForgotPasswordInitialState extends ApplicationState {
  const ForgotPasswordInitialState();
}

class ForgotPasswordEmailSentState extends ApplicationState {
  final bool emailSentStatus;
  const ForgotPasswordEmailSentState({required this.emailSentStatus});
}

class ForgotPasswordErrorState extends ApplicationState {
  final String message;
  const ForgotPasswordErrorState({required this.message});
}
