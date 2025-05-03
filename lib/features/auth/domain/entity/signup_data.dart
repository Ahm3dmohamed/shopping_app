class SignUpDataEntity {
  String name;
  String email;
  String password;
  String passwordConfirmed;
  String phone;
  SignUpDataEntity(
      {required this.email,
      required this.phone,
      required this.passwordConfirmed,
      required this.name,
      required this.password});
}
