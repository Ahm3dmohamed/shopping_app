// import 'package:equatable/equatable.dart';

abstract class CategoresEvent {}

class GetHomeCategoriesEvent extends CategoresEvent {}

class GetSubCategoriesEvent extends CategoresEvent {
  final String id;
  GetSubCategoriesEvent(this.id);

  @override
  List<Object?> get props => [id];
}
