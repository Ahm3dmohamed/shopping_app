import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/api/end_points.dart';
import 'package:ecommerce_app/core/cache/shared_preferance.dart';
import 'package:ecommerce_app/features/auth/data/data_resource/remote/auth_remote_ds.dart';
import 'package:ecommerce_app/features/auth/domain/entity/signup_data.dart';
import 'package:flutter/material.dart';

class AuthRemoteDsImpl implements AuthRemoteDs {
  final dio = Dio();

  @override
  Future<bool> login(String email, String password) async {
    try {
      var response = await dio.post(
        EndPoints.login,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          validateStatus: (status) => true,
        ),
        data: {
          "email": email.trim(),
          "password": password,
        },
      );

      if (response.statusCode == 200 && response.data["token"] != null) {
        await SharedPrefService.setValue<String>(
            "token", response.data["token"]);
        debugPrint("✅ Login successful!");
        return true;
      } else {
        debugPrint("❌ Login failed: ${response.data}");
        return false;
      }
    } catch (e) {
      debugPrint("🚨 Exception: $e");
      return false;
    }
  }

  @override
  Future<bool> signUp(SignUpDataEntity entity) async {
    try {
      var response = await dio.post(
        EndPoints.signUp,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          validateStatus: (status) => true,
        ),
        data: {
          "name": entity.name,
          "email": entity.email,
          "password": entity.password,
          "phone": entity.phone,
          "passwordConfirm": entity.passwordConfirmed,
        },
      );

      if (response.statusCode == 200 && response.data["token"] != null) {
        SharedPrefService.setValue<String>("token", response.data["token"]);
        debugPrint("✅ Sign up successful!");
        return true;
      } else {
        debugPrint("❌ Sign up failed: ${response.data}");
        return false;
      }
    } catch (e) {
      debugPrint("exeption: $e");
      return false;
    }
  }
}
