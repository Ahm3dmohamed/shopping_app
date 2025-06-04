import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/exceptions/failure.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';
import 'package:ecommerce_app/features/products_screen/data/data_source/products_ds.dart';
import '../../domain/repo/products_repo.dart';

class ProductsRepoImpl implements ProductsRepo {
  ProductsDs _productsDs;
  ProductsRepoImpl(this._productsDs);
  @override
  Future<Either<RouteFailures, CategoryModel>> getProducts() async {
    try {
      var data = await _productsDs.getProducts();
      return right(data);
    } catch (e) {
      return left(RemoteFailures(e.toString()));
    }
  }
}
