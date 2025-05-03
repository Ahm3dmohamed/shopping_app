import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/exceptions/failure.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/repository/home_repo.dart';
import 'package:flutter/material.dart';

class HomeCategoriesUsecase {
  final HomeRepo _homeRepository;

  HomeCategoriesUsecase(this._homeRepository);

  Future<Either<RouteFailures, CategoryModel>> call() async {
    return await _homeRepository.getCategories();
  }
}
