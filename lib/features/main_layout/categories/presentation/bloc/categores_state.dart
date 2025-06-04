// import 'package:ecommerce_app/core/exceptions/failure.dart';
// import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';

// import '../../../../../core/resources/enum.dart';

// class CategoresState {
//   final RequestState? categoriesState;
//   final CategoryModel? categories;
//   final RouteFailures? failure;
//   final CategoryModel? subCategorymodel;
//   final RequestState? subCategoriesState;

//   const CategoresState({
//     this.subCategoriesState,
//     this.subCategorymodel,
//     this.categoriesState,
//     this.categories,
//     this.failure,
//   });

//   CategoresState copyWith({
//     RequestState? categoriesState,
//     CategoryModel? categories,
//     RouteFailures? failure,
//     CategoryModel? subCategorymodel,
//     RequestState? subCategoriesState,
//   }) {
//     return CategoresState(
//       categoriesState: categoriesState ?? this.categoriesState,
//       subCategoriesState: subCategoriesState ?? this.subCategoriesState,
//       categories: categories ?? this.categories,
//       subCategorymodel: subCategorymodel ?? this.subCategorymodel,
//       failure: failure ?? this.failure,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         categoriesState,
//         categories,
//         failure,
//         subCategoriesState,
//         subCategorymodel
//       ];
// }

// final class CategoresInitial extends CategoresState {
//   const CategoresInitial()
//       : super(
//             categoriesState: RequestState.initial,
//             subCategoriesState: RequestState.initial);
// }
import 'package:equatable/equatable.dart';
import '../../../home/data/model/category_model/category_model.dart';
import '../../../home/data/model/category_model/datum.dart';

class CategoresState extends Equatable {
  final List<Datum> categories;
  final List<Datum> subCategorymodel;
  final bool isLoading;
  final String? error;

  const CategoresState({
    required this.categories,
    required this.subCategorymodel,
    this.isLoading = false,
    this.error,
  });

  CategoresState copyWith({
    List<Datum>? categories,
    List<Datum>? subCategorymodel,
    bool? isLoading,
    String? error,
  }) {
    return CategoresState(
      categories: categories ?? this.categories,
      subCategorymodel: subCategorymodel ?? this.subCategorymodel,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [categories, subCategorymodel, isLoading, error];
}
