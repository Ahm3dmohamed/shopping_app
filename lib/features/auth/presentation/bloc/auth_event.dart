import 'package:ecommerce_app/features/auth/domain/entity/signup_data.dart';

class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthEvent {
  SignUpDataEntity signUpDataEntity;
  SignUpEvent({required this.signUpDataEntity});
}
