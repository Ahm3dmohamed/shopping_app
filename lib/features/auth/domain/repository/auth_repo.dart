import 'package:ecommerce_app/features/auth/domain/entity/signup_data.dart';

abstract class AuthRepo {
  Future<bool> login(String email, String password);
  Future<bool> signUp(SignUpDataEntity signUpEntity);
  Future<bool> forgetPassword();
}
