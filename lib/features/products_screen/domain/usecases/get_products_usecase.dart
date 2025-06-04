import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/exceptions/failure.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';
import 'package:ecommerce_app/features/products_screen/domain/repo/products_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUsecase {
  ProductsRepo repo;
  GetProductsUsecase(this.repo);
  Future<Either<RouteFailures, CategoryModel>> call() async {
    return await repo.getProducts();
  }
}
