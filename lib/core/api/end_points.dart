import 'package:ecommerce_app/core/api/api_manager.dart';

class EndPoints {
  static const String login = "${baseUrl}api/v1/auth/signin";
  static const String signUp = "${baseUrl}api/v1/auth/signup";
  static const String forgetPass = "${baseUrl}api/v1/auth/forget-password";
  static const String resetPass = "${baseUrl}api/v1/auth/reset-password";
  static const String homeCategories = "${baseUrl}api/v1/categories";
  // static const String subCategories = "${baseUrl}api/v1/categories/$id/subcategories";
  static const String homeProducts = "${baseUrl}/api/v1/products";
  // static const String homeProductDetails = "${baseUrl}/api/v1/products/";
  // static const String homeProductSearch = "${baseUrl}/api/v1/products/search";
  // static const String homeProductFilter = "${baseUrl}/api/v1/products/filter";
  // static const String homeProductAddToCart = "${baseUrl}/api/v1/cart/add";
  // static const String homeProductRemoveFromCart = "${baseUrl}/api/v1/cart/remove";
}
