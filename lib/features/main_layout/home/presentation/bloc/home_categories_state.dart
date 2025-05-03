part of 'home_categories_bloc.dart';

class HomeCategoriesState {
  final RequestState? requestState;
  final CategoryModel? categories;
  final RouteFailures? failure;

  const HomeCategoriesState({
    this.requestState,
    this.categories,
    this.failure,
  });

  HomeCategoriesState copyWith({
    RequestState? requestState,
    CategoryModel? categories,
    RouteFailures? failure,
  }) {
    return HomeCategoriesState(
      requestState: requestState ?? this.requestState,
      categories: categories ?? this.categories,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [requestState, categories, failure];
}

final class HomeCategoriesInitial extends HomeCategoriesState {
  const HomeCategoriesInitial() : super(requestState: RequestState.initial);
}
