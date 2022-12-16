import 'dart:io';

import 'package:e_commers/Bloc/category/category_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/Admin/admin_page.dart';
import 'package:e_commers/ui/Views/Profile/profile_page.dart';
import 'package:e_commers/ui/themes/colors_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddCategoryPage extends StatefulWidget {
  AddCategoryPage({Key? key}) : super(key: key);

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  late TextEditingController _nameCategoryController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _nameCategoryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameCategoryController.clear();
    _nameCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);

    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is LoadingCategoryState) {
          modalLoading(context, 'Checking...');
        } else if (state is FailureCategoryState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessCategoryState) {
          Navigator.pop(context);
          modalSuccess(context, 'Category Added!', onPressed: () {
            Navigator.pushAndRemoveUntil(
                context, routeSlide(page: AdminPage()), (_) => false);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextFrave(
              text: 'Tambah Kategori Baru',
              fontSize: 20,
              fontWeight: FontWeight.bold),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black87),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    categoryBloc.add(OnSaveNewCategoryEvent(
                        _nameCategoryController.text.trim(),
                        categoryBloc.state.pathImage!));
                  }
                },
                child: const TextFrave(
                    text: 'Save',
                    color: ColorsFrave.primaryColorFrave,
                    fontWeight: FontWeight.w500))
          ],
        ),
        body: Form(
          key: _keyForm,
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            children: [
              InkWell(
                onTap: () => modalSelectPicture(
                  context: context,
                  onPressedImage: () async {
                    Navigator.pop(context);
                    AccessPermission()
                        .permissionAccessGalleryOrCameraForCategory(
                            await Permission.storage.request(),
                            context,
                            ImageSource.gallery);
                  },
                  onPressedPhoto: () async {
                    Navigator.pop(context);
                    AccessPermission()
                        .permissionAccessGalleryOrCameraForCategory(
                            await Permission.camera.request(),
                            context,
                            ImageSource.camera);
                  },
                ),
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (_, state) => state.pathImage != null
                      ? Container(
                          height: 190,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(state.pathImage!)))),
                        )
                      : Container(
                          height: 190,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Color(0xfff3f3f3),
                              borderRadius: BorderRadius.circular(12.0)),
                          child: const Icon(Icons.wallpaper_rounded, size: 80),
                        ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormFrave(
                controller: _nameCategoryController,
                prefixIcon: const Icon(Icons.add),
                hintText: 'Name Category',
                validator: RequiredValidator(errorText: 'name is required'),
              ),
              // const SizedBox(height: 20.0),
              // TextFormFrave(
              //   controller: _descriptionProductController,
              //   prefixIcon: const Icon(Icons.add),
              //   hintText: 'Description Product',
              //   validator:
              //       RequiredValidator(errorText: 'Description is required'),
              // ),
              // const SizedBox(height: 20.0),
              // TextFormFrave(
              //   controller: _stockController,
              //   prefixIcon: const Icon(Icons.add),
              //   hintText: 'Stock',
              //   keyboardType: TextInputType.number,
              //   validator: RequiredValidator(errorText: 'Stock is required'),
              // ),
              // const SizedBox(height: 20.0),
              // TextFormFrave(
              //   controller: _priceController,
              //   prefixIcon: const Icon(Icons.add),
              //   hintText: 'Price',
              //   keyboardType: TextInputType.number,
              //   validator: RequiredValidator(errorText: 'Price is required'),
              // ),
              // const SizedBox(height: 20.0),
              // InkWell(
              //   onTap: () => modalCategoies(context, size),
              //   borderRadius: BorderRadius.circular(10.0),
              //   child: Container(
              //       alignment: Alignment.centerLeft,
              //       padding: const EdgeInsets.only(left: 20.0),
              //       height: 50,
              //       width: size.width,
              //       decoration: BoxDecoration(
              //           color: Color(0xfff3f3f3),
              //           borderRadius: BorderRadius.circular(10.0)),
              //       child: BlocBuilder<CategoryBloc, CategoryState>(
              //           builder: (_, state) => state.uidCategory != null
              //               ? TextFrave(
              //                   text: state.nameCategory!,
              //                   color: Colors.black54)
              //               : TextFrave(
              //                   text: 'Select Category',
              //                   color: Colors.black54))),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
