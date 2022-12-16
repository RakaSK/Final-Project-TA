part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class OnSelectUidCategoryEvent extends CategoryEvent {
  final int uidCategory;
  final String category;

  OnSelectUidCategoryEvent(this.uidCategory, this.category);
} 

class OnSaveNewCategoryEvent extends CategoryEvent {
  final String name;
  final String image;

  OnSaveNewCategoryEvent(this.name, this.image);
}

class OnSelectPathImageCategoryEvent extends CategoryEvent {
  final String image;

  OnSelectPathImageCategoryEvent(this.image);
}

class OnDeleteCategoryEvent extends CategoryEvent {
  final String uidCategory;

  OnDeleteCategoryEvent(this.uidCategory);
}


