import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/exceptions/failure.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';

abstract class HomeRepo {
  Future<Either<RouteFailures, CategoryModel>> getCategories();
}
