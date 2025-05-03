import 'package:ecommerce_app/features/auth/domain/entity/signup_data.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repo.dart';

class SignUpUsecase {
  AuthRepo authRepo;
  SignUpUsecase(this.authRepo);
  Future<bool> call(SignUpDataEntity signUpEntity) =>
      authRepo.signUp(signUpEntity);
}

///................................................Handel this Function............................
