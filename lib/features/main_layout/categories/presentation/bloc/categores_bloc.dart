import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/usecases/home_categories_usecase.dart';
import '../../domain/usecases/get_subcategories_use_cases.dart';
import 'categores_event.dart';
import 'categores_state.dart';

class CategoresBloc extends Bloc<CategoresEvent, CategoresState> {
  final HomeCategoriesUsecase homeCategoriesUsecase;
  final GetSubcategoriesUseCases getSubcategoriesUseCases;

  CategoresBloc(this.homeCategoriesUsecase, this.getSubcategoriesUseCases)
      : super(const CategoresState(categories: [], subCategorymodel: [])) {
    on<GetHomeCategoriesEvent>(_onGetCategories);
    on<GetSubCategoriesEvent>(_onGetSubCategories);
  }

  Future<void> _onGetCategories(
      GetHomeCategoriesEvent event, Emitter<CategoresState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await homeCategoriesUsecase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (data) =>
          emit(state.copyWith(categories: data.data ?? [], isLoading: false)),
    );
  }

  Future<void> _onGetSubCategories(
      GetSubCategoriesEvent event, Emitter<CategoresState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getSubcategoriesUseCases.call(event.id);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (data) => emit(
          state.copyWith(subCategorymodel: data.data ?? [], isLoading: false)),
    );
  }
}
