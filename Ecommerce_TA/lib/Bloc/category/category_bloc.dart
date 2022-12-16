import 'package:bloc/bloc.dart';
import 'package:e_commers/Service/category_services.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<OnSelectUidCategoryEvent>(_selectUidCategory);
    on<OnSelectPathImageCategoryEvent>(_selectImageForCategory);
    on<OnSaveNewCategoryEvent>(_addNewCategory);
    on<OnDeleteCategoryEvent>(_deleteCategory);
  }

  Future<void> _selectUidCategory(
      OnSelectUidCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(SetSelectCategoryState(event.uidCategory, event.category));
  }

  Future<void> _selectImageForCategory(
      OnSelectPathImageCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(SetImageForCategoryState(event.image));
  }

  Future<void> _addNewCategory(
      OnSaveNewCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(LoadingCategoryState());

      final data =
          await categoryServices.addNewCategory(event.name, event.image);

      if (data.resp) {
        emit(SuccessCategoryState());
      } else {
        emit(FailureCategoryState(data.message));
      }
    } catch (e) {
      emit(FailureCategoryState(e.toString()));
    }
  }

  Future<void> _deleteCategory(
      OnDeleteCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(LoadingCategoryState());

      final data = await categoryServices.deleteCategory(event.uidCategory);

      await Future.delayed(Duration(seconds: 1));

      if (data.resp) {
        emit(SuccessCategoryState());
      } else {
        emit(FailureCategoryState(data.message));
      }
    } catch (e) {
      emit(FailureCategoryState(e.toString()));
    }
  }
}
