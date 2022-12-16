import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Models/Response/response_keranjang.dart';
import 'package:e_commers/Service/keranjang_services.dart';
import 'package:e_commers/Service/pembayaran_services.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/ui/Views/Profile/shopping/order_details_page.dart';
import 'package:e_commers/ui/Views/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Models/Response/response_order_buy.dart';
import 'package:e_commers/Service/product_services.dart';
import 'package:e_commers/ui/themes/colors_frave.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../checkout_page.dart';

class KeranjangDB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResponseKeranjang>(
      future: keranjangServices.getAllKeranjang(),
      builder: (_, snapshot) {
        return (!snapshot.hasData)
            ? const ShimmerFrave()
            : _DetailsKeranjang(keranjang: snapshot.data!);
      },
    );
  }
}

class _DetailsKeranjang extends StatelessWidget {
  final ResponseKeranjang keranjang;

  const _DetailsKeranjang({Key? key, required this.keranjang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return !keranjang.resp
        ? Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Center(
              child: Text(keranjang.msg),
            ))
        : Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .85,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  itemCount: keranjang.keranjang.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.all(15.0),
                      height: MediaQuery.of(context).size.height * 0.232,
                      // height: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xffF5F5F5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: TextFrave(
                                      text: keranjang.keranjang[i].nameProduct
                                          .toString(),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis)),
                              GestureDetector(
                                  onTap: () {
                                    productBloc.add(OnDeleteKeranjangEvent(
                                        keranjang
                                            .keranjang[i].uidKeranjangDetails
                                            .toString()));
                                    // Navigator.pop(context);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        routeSlide(page: CartPage()),
                                        (_) => false);
                                    // print(keranjang.keranjang[i].uidKeranjang);
                                  },
                                  child: Icon(Icons.close,
                                      color: Colors.red, size: 25))
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  height: 90,
                                  width: 90,
                                  child: Image.network(URLS.baseUrl +
                                      keranjang.keranjang[i].picture)),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10.0),
                                  TextFrave(
                                      text:
                                          '\Rp. ${keranjang.keranjang[i].priceawal}',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(height: 20.0),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .55,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    bottomLeft:
                                                        Radius.circular(10.0))),
                                            child: const Icon(Icons.remove,
                                                color: ColorsFrave
                                                    .primaryColorFrave),
                                          ),
                                          onTap: () {
                                            // if (state.products![i].amount > 1) {
                                            //   productBloc
                                            //       .add(OnSubtractQuantityProductEvent(i));
                                            // }
                                            productBloc.add(
                                                OnPlusQuantityProductEvent(
                                                    'minus',
                                                    keranjang.keranjang[i]
                                                        .uidKeranjangDetails
                                                        .toString(),
                                                    context));
                                            // Future.delayed(Duration(seconds: 1));
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    routeSlide(
                                                        page: CartPage()),
                                                    (_) => false);
                                          },
                                        ),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          color: Colors.white,
                                          child: Center(
                                              child: TextFrave(
                                                  text:
                                                      '${keranjang.keranjang[i].quantity}',
                                                  fontSize: 18)),
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10.0),
                                                    bottomRight:
                                                        Radius.circular(10.0))),
                                            child: const Icon(Icons.add,
                                                color: ColorsFrave
                                                    .primaryColorFrave),
                                          ),
                                          onTap: () {
                                            // productBloc.add(
                                            //     OnPlusQuantityProductEvent(i));
                                            productBloc.add(
                                                OnPlusQuantityProductEvent(
                                                    'plus',
                                                    keranjang.keranjang[i]
                                                        .uidKeranjangDetails
                                                        .toString(),
                                                    context));
                                            // Future.delayed(Duration(seconds: 1));
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    routeSlide(
                                                        page: CartPage()),
                                                    (_) => false);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.height * 0.130,
                                child: TextFrave(
                                    text:
                                        '\Rp. ${keranjang.keranjang[i].price}',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: -3,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 10,
                            spreadRadius: 5)
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextFrave(
                                text: 'Total',
                                fontSize: 23,
                                fontWeight: FontWeight.w600),
                            TextFrave(
                                text:
                                    '\Rp. ${keranjang.amount.toStringAsFixed(0)}',
                                // text: '\Rp ${keranjang[i].amount}',
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18.0),
                      BtnFrave(
                        text: 'Checkout',
                        fontSize: 22,
                        // width: MediaQuery.of(context).size.width * 0.9,
                        width: 335,
                        height: 56,
                        border: 15,
                        onPressed: () {
                          if (keranjang.keranjang.isNotEmpty) {
                            Navigator.push(
                              context,
                              routeSlide(page: CheckOutPage()),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
