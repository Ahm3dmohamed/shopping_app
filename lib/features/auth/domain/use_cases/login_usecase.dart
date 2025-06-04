import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/exceptions/failure.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUsecase {
  AuthRepo authRepo;
  LoginUsecase(this.authRepo);

  Future<Either<RouteFailures, bool>> call(
      String email, String password) async {
    try {
      final result = await authRepo.login(email, password);
      return Right(result); // Wrap the result in a Right instance
    } catch (e) {
      // Handle exceptions and wrap them in a Left instance
      return Left(RouteFailures());
    }
  }
}
