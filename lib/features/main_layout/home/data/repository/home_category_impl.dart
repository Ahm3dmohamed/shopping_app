import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/exceptions/failure.dart';
import 'package:ecommerce_app/features/main_layout/home/data/datasource/remote/home_category_remote_ds.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/repository/home_repo.dart';

class HomeCategoryImpl implements HomeRepo {
  final HomeCategoryRemoteDs homeDs;

  HomeCategoryImpl(this.homeDs);

  @override
  Future<Either<RouteFailures, CategoryModel>> getCategories() async {
    try {
      var data = await homeDs.getCategories();
      return Right(data);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }
}
