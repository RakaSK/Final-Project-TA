import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/Service/product_services.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/ui/Views/Admin/admin_page.dart';
import 'package:e_commers/ui/Views/Admin/product/add_product_page.dart';
import 'package:e_commers/ui/themes/colors_frave.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';

class ListProductsPage extends StatefulWidget {
  @override
  State<ListProductsPage> createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is LoadingProductState) {
          modalLoading(context, 'Loading');
        } else if (state is SuccessProductState) {
          Navigator.pop(context);
          modalSuccess(context, 'Success', onPressed: () {
            Navigator.pushAndRemoveUntil(
                context, routeSlide(page: ListProductsPage()), (_) => false);
          });
        } else if (state is FailureProductState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextFrave(text: 'Daftar Produk', fontSize: 19),
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
                    Navigator.push(context, routeFade(page: AddProductPage())),
                child: const TextFrave(
                    text: 'Tambah',
                    fontSize: 17,
                    color: ColorsFrave.primaryColorFrave))
          ],
        ),
        body: FutureBuilder<List<ListProducts>>(
            future: productServices.listProductsHome(),
            builder: (context, snapshot) => (!snapshot.hasData)
                ? const ShimmerFrave()
                : _GridViewListProduct(listProducts: snapshot.data!)),
      ),
    );
  }
}

class _GridViewListProduct extends StatelessWidget {
  final List<ListProducts> listProducts;

  const _GridViewListProduct({required this.listProducts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      itemCount: listProducts.length,
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
        onLongPress: () => modalDeleteProduct(
            context,
            listProducts[i].nameProduct,
            listProducts[i].picture,
            listProducts[i].uidProduct.toString()),
        child: Row(
          children: [
            Container(
              // height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      scale: 7,
                      image: NetworkImage(
                          URLS.baseUrl + listProducts[i].picture))),
            ),
            // TextFrave(text: '\Stock ${listProducts[i].stock}', fontSize: 14),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: (listProducts[i].status == 'active')
                                ? Colors.grey[50]
                                : Colors.red[100]),
                      ),
                      TextFrave(
                          text: '\Nama = ${listProducts[i].nameProduct}',
                          // '\Stock = ${listProducts[i].stock}',
                          fontSize: 17,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis),
                      TextFrave(
                          text: '\Stock = ${listProducts[i].stock}',
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
