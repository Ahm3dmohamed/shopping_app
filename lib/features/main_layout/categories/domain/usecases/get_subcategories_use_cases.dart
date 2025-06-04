import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/exceptions/failure.dart';
import 'package:ecommerce_app/features/main_layout/categories/domain/repo/categories_repo.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubcategoriesUseCases {
  final SubCategoriesRepo _categoriesRepo;
  GetSubcategoriesUseCases(this._categoriesRepo);
  @override
  Future<Either<RouteFailures, CategoryModel>> call(String id) async {
    return await _categoriesRepo.getSubCategories(id);
  }
}
