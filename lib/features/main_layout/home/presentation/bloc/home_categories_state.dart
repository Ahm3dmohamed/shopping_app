part of 'home_categories_bloc.dart';

class HomeCategoriesState {
  final RequestState? requestState;
  final RequestState? subCategoriesState;
  final CategoryModel? categories;
  final CategoryModel? subCategorymodel;
  final RouteFailures? failure;

  const HomeCategoriesState({
    this.subCategoriesState,
    this.subCategorymodel,
    this.requestState,
    this.categories,
    this.failure,
  });

  HomeCategoriesState copyWith({
    RequestState? requestState,
    CategoryModel? categories,
    CategoryModel? subCategorymodel,
    RequestState? subCategoriesState,
    RouteFailures? failure,
  }) {
    return HomeCategoriesState(
      subCategorymodel: subCategorymodel ?? this.subCategorymodel,
      subCategoriesState: subCategoriesState ?? this.subCategoriesState,
      requestState: requestState ?? this.requestState,
      categories: categories ?? this.categories,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        requestState,
        categories,
        failure,
      ];
}

final class HomeCategoriesInitial extends HomeCategoriesState {
  const HomeCategoriesInitial() : super(requestState: RequestState.initial);
}
