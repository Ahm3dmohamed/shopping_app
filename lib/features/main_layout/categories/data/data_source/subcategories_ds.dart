import 'package:ecommerce_app/core/api/api_manager.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';
import 'package:injectable/injectable.dart';

abstract class SubcategoriesDs {
  Future<CategoryModel> getSubCategories(String id);
}

@Injectable(as: SubcategoriesDs)
class SubcategoriesDsImpl implements SubcategoriesDs {
  ApiManager apiManager;
  SubcategoriesDsImpl(this.apiManager);
  @override
  Future<CategoryModel> getSubCategories(String id) async {
    var response = await apiManager.getData(
        endPoints: "${baseUrl}api/v1/categories/$id/subcategories");
    CategoryModel categoryModel = CategoryModel.fromJson(response.data);
    return categoryModel;
  }
}
