import 'package:app/core/data/repositories/auth/auth_repository_impl.dart';
import 'package:app/features/home/presentation/business_components/home_cubit.dart';
import 'package:app/features/auth/domain/use_cases/auth_use_case_impl.dart';
import 'package:app/features/auth/presentation/business_components/auth_cubit.dart';

class CubitFactory {
  static AuthCubit get authCubit => AuthCubit(
        authUseCase: AuthUseCaseImpl(
          authRepository: AuthRepositoryImpl(),
        ),
      );

  static HomeCubit get homeCubit => HomeCubit(
        authUseCase: AuthUseCaseImpl(
          authRepository: AuthRepositoryImpl(),
        ),
      );
}
