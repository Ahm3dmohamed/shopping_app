import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/api/api_manager.dart';
import 'package:ecommerce_app/core/api/end_points.dart';
import 'package:ecommerce_app/core/exceptions/failure.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';
import 'package:injectable/injectable.dart';

abstract class ProductsDs {
  Future<CategoryModel> getProducts();
}

@Injectable(as: ProductsDs)
class ProductsDsImpl implements ProductsDs {
  ApiManager _apiManager;
  ProductsDsImpl(this._apiManager);
  @override
  Future<Either<RouteFailures, CategoryModel>> getProducts() {
    var responce = _apiManager.getData(endPoints: EndPoints.homeProducts);
    CategoryModel productmodel = CategoryModel.fromJson(responce.data);
    return productmodel;
  }
}
