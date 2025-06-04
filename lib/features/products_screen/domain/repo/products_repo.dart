import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';

import '../../../../core/exceptions/failure.dart';

abstract class ProductsRepo {
  Future<Either<RouteFailures, CategoryModel>> getProducts();
}
