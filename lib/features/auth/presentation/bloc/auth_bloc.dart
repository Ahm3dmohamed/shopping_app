import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/resources/enum.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/login_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/sign_up_usecase.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;
  AuthBloc(this.loginUsecase, this.signUpUsecase) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(AuthState(requestState: RequestState.loading));

        var data = await loginUsecase.call(event.email, event.password);
        data.fold((failure) {
          emit(state.copyWith(
              requestState: RequestState.error,
              errorMessage: "Invalid credentials"));
        },
            (success) => emit(state.copyWith(
                  requestState: RequestState.success,
                )));
      } catch (e) {
        emit(state.copyWith(
            requestState: RequestState.error, errorMessage: e.toString()));
      }
    });

    ///................................................Handel this Function............................

    on<SignUpEvent>((event, emit) async {
      try {
        emit(AuthState(requestState: RequestState.loading));

        bool signUp = await signUpUsecase.call(event.signUpDataEntity);

        if (signUp) {
          emit(state.copyWith(requestState: RequestState.success));
        } else {
          emit(state.copyWith(
              requestState: RequestState.error,
              errorMessage: "Invalid credentials"));
        }
      } catch (e) {
        emit(state.copyWith(
            requestState: RequestState.error, errorMessage: e.toString()));
      }
    });
  }
}
