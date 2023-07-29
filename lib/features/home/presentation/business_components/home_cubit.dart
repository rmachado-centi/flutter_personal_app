import 'package:app/core/blocs/application_state.dart';
import 'package:app/core/data/models/user_model.dart';
import 'package:app/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<ApplicationState> {
  final AuthUseCase authUseCase;
  HomeCubit({required this.authUseCase}) : super(const HomeInitialState());

  void getHomeData() async {
    try {
      final uid = await authUseCase.getUserUUID();
      if (uid == null) {
        return;
      }
      final name = await authUseCase.getUserName(uid);
      final email = await authUseCase.getUserEmail();
      final imageURL = await authUseCase.getUserImageURL(uid);
      final user = UserModel(name: name, email: email, imageUrl: imageURL);
      emit(HomeUserDataSuccessState(user: user));
    } catch (e) {
      // Handle any exceptions that occur during the check
      // You can show an error message here if required
    }
  }

  void signOut() async {
    // Implement Firebase sign-out here
    // Update the state accordingly.
    try {
      await authUseCase.signOut();
      emit(const HomeSignOutSuccessState());
    } catch (e) {
      // Handle any exceptions that occur during sign-out
      // You can show an error message here if required
    }
  }
}
