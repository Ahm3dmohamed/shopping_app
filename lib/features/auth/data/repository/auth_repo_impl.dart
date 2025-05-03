import 'package:ecommerce_app/features/auth/data/data_resource/remote/auth_remote_ds.dart';
import 'package:ecommerce_app/features/auth/domain/entity/signup_data.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRemoteDs authRemoteDs;
  AuthRepoImpl(this.authRemoteDs);
  @override
  Future<bool> forgetPassword() {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> login(String email, String password) async {
    try {
      bool loggedIn = await authRemoteDs.login(email, password);
      return loggedIn;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signUp(SignUpDataEntity signUpEntity) async {
    try {
      bool signUp = await authRemoteDs.signUp(signUpEntity);
      return signUp;
    } catch (e) {
      return false;
    }
  }
}
