import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';

abstract class HomeCategoryRemoteDs {
  Future<CategoryModel> getCategories();
  // Future<List<String>> getSubCategories(String category);
  // Future<List<String>> getProducts(String subCategory);
  // Future<List<String>> getProductDetails(String productId);
  // Future<List<String>> getProductReviews(String productId);
  // Future<bool> addToCart(String productId, int quantity);
  // Future<bool> removeFromCart(String productId);
  // Future<List<String>> getCartItems();
  // Future<bool> placeOrder(List<String> cartItems);
}
