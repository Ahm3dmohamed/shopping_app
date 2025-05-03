import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/exceptions/failure.dart';
import 'package:ecommerce_app/core/resources/enum.dart';
import 'package:ecommerce_app/features/main_layout/home/data/model/category_model/category_model.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/usecases/home_categories_usecase.dart';
import 'package:flutter/material.dart';

part 'home_categories_event.dart';
part 'home_categories_state.dart';

class HomeCategoriesBloc extends Bloc<HomeEvent, HomeCategoriesState> {
  final HomeCategoriesUsecase homeCategoriesUsecase;

  HomeCategoriesBloc(this.homeCategoriesUsecase)
      : super(const HomeCategoriesInitial()) {
    on<GetHomeCategoriesEvent>((event, emit) async {
      emit(state.copyWith(requestState: RequestState.loading));
      var result = await homeCategoriesUsecase.call();
      result.fold(
        (failure) => emit(
            state.copyWith(requestState: RequestState.error, failure: failure)),
        (success) => emit(state.copyWith(
            requestState: RequestState.success, categories: success)),
      );
    });
  }
}
