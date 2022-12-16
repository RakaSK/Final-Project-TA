part of 'category_bloc.dart';

@immutable
abstract class CategoryState {
  final int? uidCategory;
  final String? nameCategory;
  final String? pathImage;

  CategoryState({this.uidCategory, this.nameCategory, this.pathImage});
}

class CategoryInitial extends CategoryState {}

class SetSelectCategoryState extends CategoryState {
  final uid;
  final category;

  SetSelectCategoryState(this.uid, this.category)
      : super(uidCategory: uid, nameCategory: category);
}

class SetImageForCategoryState extends CategoryState {
  final String path;

  SetImageForCategoryState(this.path) : super(pathImage: path);
}

class LoadingCategoryState extends CategoryState {}

class SuccessCategoryState extends CategoryState {}

class FailureCategoryState extends CategoryState {
  final String error;

  FailureCategoryState(this.error);
}
