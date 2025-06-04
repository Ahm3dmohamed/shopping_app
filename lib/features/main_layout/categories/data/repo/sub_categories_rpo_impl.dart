import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/exceptions/failure.dart';
import 'package:ecommerce_app/features/main_layout/categories/data/data_source/subcategories_ds.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/repo/categories_repo.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SubCategoriesRepo)
class CategoriesRpoImpl implements SubCategoriesRepo {
  SubcategoriesDs subcategoriesDs;
  CategoriesRpoImpl(this.subcategoriesDs);
  @override
  Future<Either<RouteFailures, CategoryModel>> getSubCategories(
      String id) async {
    try {
      var data = await subcategoriesDs.getSubCategories(id);
      return right(data);
    } catch (e) {
      return left(RemoteFailures(e.toString()));
    }
  }
}
