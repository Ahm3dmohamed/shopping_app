import 'package:ecommerce_app/features/domain/entity/signup_data.dart';

abstract class AuthRepo {
  Future<bool> login(String password, String email);
  Future<bool> signUp(SignUpDataEntity signUpEntity);
  Future<bool> forgetPassword();
}
