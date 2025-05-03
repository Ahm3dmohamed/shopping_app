import 'package:ecommerce_app/core/resources/enum.dart';

class AuthState {
  RequestState? requestState;
  bool? isLogin;
  bool? isSignUp;
  String? errorMessage;
  AuthState(
      {this.requestState, this.isSignUp, this.isLogin, this.errorMessage});

  copyWith(
      {RequestState? requestState,
      bool? isSignUp,
      bool? isLogin,
      String? errorMessage}) {
    return AuthState(
        errorMessage: errorMessage ?? this.errorMessage,
        isLogin: isLogin ?? this.isLogin,
        isSignUp: isSignUp ?? this.isSignUp,
        requestState: requestState ?? this.requestState);
  }
}

final class AuthInitial extends AuthState {
  AuthInitial()
      : super(
          requestState: RequestState.initial,
        );
}
