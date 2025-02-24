import 'package:ecommerce_app/features/domain/repository/auth_repo.dart';

class LoginUsecase {
  AuthRepo authRepo;
  LoginUsecase(this.authRepo);

  call(String email, String password) => authRepo.login(email, email);
}
