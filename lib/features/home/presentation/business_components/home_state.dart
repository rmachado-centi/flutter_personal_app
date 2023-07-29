part of 'home_cubit.dart';

class HomeInitialState extends ApplicationState {
  const HomeInitialState();
}

class HomeUserDataSuccessState extends ApplicationState {
  final UserModel user;
  const HomeUserDataSuccessState({required this.user});
}

class HomeSignOutSuccessState extends ApplicationState {
  const HomeSignOutSuccessState();
}
