import 'package:e_commers/Bloc/category/category_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Models/Response/response_categories_home.dart';
import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/Service/category_services.dart';
import 'package:e_commers/Service/product_services.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/ui/Views/Admin/admin_page.dart';
import 'package:e_commers/ui/Views/Admin/category/add_category_page.dart';
import 'package:e_commers/ui/Views/Admin/product/add_product_page.dart';
import 'package:e_commers/ui/themes/colors_frave.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';

class ListCategoryPage extends StatefulWidget {
  @override
  State<ListCategoryPage> createState() => _ListCategoryPageState();
}

class _ListCategoryPageState extends State<ListCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is LoadingCategoryState) {
          modalLoading(context, 'Loading');
        } else if (state is SuccessCategoryState) {
          Navigator.pop(context);
          modalSuccess(context, 'Success', onPressed: () {
            Navigator.pushAndRemoveUntil(
                context, routeSlide(page: ListCategoryPage()), (_) => false);
          });
        } else if (state is FailureCategoryState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextFrave(text: 'Daftar Kategori', fontSize: 19),
          centerTitle: true,
          leadingWidth: 90,
          elevation: 0,
          leading: InkWell(
            onTap: () =>
                Navigator.of(context).push(routeSlide(page: AdminPage())),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_ios_new_rounded,
                    color: ColorsFrave.primaryColorFrave),
                TextFrave(
                    text: 'Kembali',
                    fontSize: 17,
                    color: ColorsFrave.primaryColorFrave)
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () =>
                    Navigator.push(context, routeFade(page: AddCategoryPage())),
                child: const TextFrave(
                    text: 'Tambah',
                    fontSize: 17,
                    color: ColorsFrave.primaryColorFrave))
          ],
        ),
        body: FutureBuilder<List<Categories>>(
            future: categoryServices.listCategoriesHome(),
            builder: (context, snapshot) => (!snapshot.hasData)
                ? const ShimmerFrave()
                : _GridViewListProduct(listCategories: snapshot.data!)),
      ),
    );
  }
}

class _GridViewListProduct extends StatelessWidget {
  final List<Categories> listCategories;

  const _GridViewListProduct({required this.listCategories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      itemCount: listCategories.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
          childAspectRatio: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15),
      itemBuilder: (context, i) => InkWell(
        // onTap: () => modalActiveOrInactiveProduct(
        //     context,
        //     listProducts[i].status,
        //     listProducts[i].nameProduct,
        //     listProducts[i].uidProduct,
        //     listProducts[i].picture),
        onLongPress: () => modalDeleteCategory(
            context,
            listCategories[i].category,
            listCategories[i].uidCategory.toString()),
        child: Row(
          children: [
            // Container(
            //   // height: 100,
            //   width: 100,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           scale: 7,
            //           image: NetworkImage(
            //               URLS.baseUrl + listProducts[i].picture))),
            // ),
            // TextFrave(text: '\Stock ${listProducts[i].stock}', fontSize: 14),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5.0),
                      //       color: (listCategories[i].status == 'active')
                      //           ? Colors.grey[50]
                      //           : Colors.red[100]),
                      // ),
                      TextFrave(
                          text:
                              '\ID Kategori = ${listCategories[i].uidCategory}',
                          // '\Stock = ${listProducts[i].stock}',
                          fontSize: 17,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis),
                      TextFrave(
                          text:
                              '\Nama Kategori = ${listCategories[i].category}',
                          fontSize: 17,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ],
              ),

              // child: Container(
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5.0),
              //       color: (listProducts[i].status == 'active')
              //           ? Colors.grey[50]
              //           : Colors.red[100]),
              //   child:
              //       TextFrave(text: listProducts[i].nameProduct, fontSize: 16),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
