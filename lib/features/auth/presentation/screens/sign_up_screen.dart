import 'package:ecommerce_app/core/resources/enum.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/features/auth/data/data_resource/remote/auth_remote_ds_impl.dart';
import 'package:ecommerce_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:ecommerce_app/features/auth/domain/entity/signup_data.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/login_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/sign_up_usecase.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widget/main_text_field.dart';
import '../../../../core/widget/validators.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
          LoginUsecase(AuthRepoImpl(AuthRemoteDsImpl())),
          SignUpUsecase(AuthRepoImpl(AuthRemoteDsImpl()))),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // if (state.requestState == RequestState.success) {
          //   Navigator.pushNamedAndRemoveUntil(
          //       context, Routes.mainRoute, (route) => false);
          // }
          if (state.requestState == RequestState.error) {
            debugPrint("Login Error:");
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          } else if (state.requestState == RequestState.success) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.mainRoute, (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.primary,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppSize.s40.h,
                      ),
                      Center(child: SvgPicture.asset(SvgAssets.routeLogo)),
                      SizedBox(
                        height: AppSize.s40.h,
                      ),
                      BuildTextField(
                        controller: nameController,
                        backgroundColor: ColorManager.white,
                        hint: 'enter your full name',
                        label: 'Full Name',
                        textInputType: TextInputType.name,
                        validation: AppValidators.validateFullName,
                      ),
                      SizedBox(
                        height: AppSize.s18.h,
                      ),
                      BuildTextField(
                        controller: phoneNumberController,
                        hint: 'enter your mobile no.',
                        backgroundColor: ColorManager.white,
                        label: 'Mobile Number',
                        validation: AppValidators.validatePhoneNumber,
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: AppSize.s18.h,
                      ),
                      BuildTextField(
                        controller: emailController,
                        hint: 'enter your email address',
                        backgroundColor: ColorManager.white,
                        label: 'E-mail address',
                        validation: AppValidators.validateEmail,
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: AppSize.s18.h,
                      ),
                      BuildTextField(
                        controller: passwordController,
                        hint: 'enter your password',
                        backgroundColor: ColorManager.white,
                        label: 'password',
                        validation: AppValidators.validatePassword,
                        isObscured: true,
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: AppSize.s18.h,
                      ),
                      BuildTextField(
                        controller: confirmPasswordController,
                        hint: 'Confirm your password',
                        backgroundColor: ColorManager.white,
                        label: 'Confirm password',
                        validation: AppValidators.validatePassword,
                        isObscured: true,
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: AppSize.s50.h,
                      ),
                      Center(
                        child: SizedBox(
                          height: AppSize.s60.h,
                          width: MediaQuery.of(context).size.width * .9,
                          child: CustomElevatedButton(
                            isLoading: false,
                            // borderRadius: AppSize.s8,
                            label: 'Sign Up',
                            backgroundColor: ColorManager.white,
                            textStyle: getBoldStyle(
                                color: ColorManager.primary,
                                fontSize: AppSize.s20),
                            onTap: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                  SignUpEvent(
                                      signUpDataEntity: SignUpDataEntity(
                                          passwordConfirmed:
                                              confirmPasswordController.text,
                                          email: emailController.text,
                                          phone: phoneNumberController.text,
                                          name: nameController.text,
                                          password: passwordController.text)));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
