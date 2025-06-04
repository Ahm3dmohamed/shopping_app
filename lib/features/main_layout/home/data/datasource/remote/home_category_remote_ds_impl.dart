import 'package:ecommerce_app/core/api/api_manager.dart';
import 'package:ecommerce_app/core/api/end_points.dart';
import 'package:ecommerce_app/features/main_layout/home/data/datasource/remote/home_category_remote_ds.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';
import 'package:flutter/foundation.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: HomeCategoryRemoteDs)
class HomeCategoryRemoteDsImpl implements HomeCategoryRemoteDs {
  final ApiManager apiManager;

  HomeCategoryRemoteDsImpl(this.apiManager);

  @override
  Future<CategoryModel> getCategories() async {
    try {
      final response = await apiManager.getData(
        endPoints: EndPoints.homeCategories,
      );

      // debugPrint(" Raw Category Response: ${response.data}");

      if (response.statusCode == 200) {
        final parsedModel = CategoryModel.fromJson(response.data);
        debugPrint(" Parsed Category Count: ${parsedModel.data?.length ?? 0}");
        return parsedModel;
      } else {
        throw Exception('Failed to load categories - ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(" Error loading categories: $e");
      throw Exception('Failed to load categories: $e');
    }
  }
}
