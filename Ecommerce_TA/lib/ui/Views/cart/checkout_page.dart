import 'package:e_commers/Bloc/Ongkir/ongkir_bloc.dart';
import 'package:e_commers/Bloc/Total/total_bloc.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Models/Response/response_keranjang.dart';
import 'package:e_commers/Models/Response/response_keranjang1.dart';
import 'package:e_commers/Service/keranjang_services.dart';
import 'package:e_commers/ui/Views/Home/home_page.dart';
import 'package:e_commers/ui/Views/Profile/PaymentPage.dart';
import 'package:e_commers/ui/Views/Profile/shopping/shopping_page.dart';
import 'package:e_commers/ui/Views/cart/widgets/order_details.dart';
import 'package:e_commers/ui/Views/cart/widgets/opsi_pengiriman.dart';
import 'package:e_commers/ui/Views/cart/widgets/promo_code.dart';
import 'package:e_commers/ui/Views/cart/widgets/street_address.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutPage extends StatelessWidget {
  int total = 0;
  int ongkir = 0;
  String kota = "";
  String estimasi = "";
  String layanankirim = "";
  String namakurir = "";

  // final ResponseKeranjang keranjang;
  // const CheckOutPage({Key? key, required this.keranjang}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // new StripeService()
    //   ..init();

    final productBloc = BlocProvider.of<ProductBloc>(context);

    final size = MediaQuery.of(context).size;

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is LoadingProductState) {
          modalLoading(context, 'Checking...');
        } else if (state is FailureProductState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessProductState) {
          // Navigator.pop(context);
          modalSuccess(context,
              'Pembelian belum selesai !! Silahkan masuk ke history belanja untuk upload bukti pembayaran !!',
              onPressed: () {
            // productBloc.add(OnClearProductsEvent());
            // Navigator.pop(context);
            Navigator.push(context, routeFade(page: ShoppingPage()));
          });
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xfff3f4f8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextFrave(
              text: 'Checkout',
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          children: [
            const StreetAddressCheckout(),
            FutureBuilder<Keranjang1>(
                future: keranjangServices.getKeranjangHarga(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return Column(
                      children: [
                        BlocBuilder<OngkirBloc, OngkirState>(
                            builder: ((context, state) {
                          if (state is OngkirInitial) {
                            return Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 10.0),
                                height: 450,
                                // height: MediaQuery.of(context).size.height * .5,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    OpsiPengiriman(
                                      jumlahquantity: snapshot
                                          .data!.jumlahquantity
                                          .toString(),
                                    ),
                                    Container(
                                      // margin: const EdgeInsets.only(top: 10.0),
                                      padding: const EdgeInsets.all(15.0),
                                      height: 90,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFrave(
                                              text: 'Estimasi Pengiriman',
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                          Divider(),
                                          TextFrave(
                                              text: 'Estimasi tidak ditemukan!',
                                              fontSize: 18),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     const TextFrave(
                                          //       text: 'Harga Ongkir',
                                          //       fontSize: 19,
                                          //     ),
                                          //     TextFrave(
                                          //       text: "0",
                                          //       fontSize: 19,
                                          //     )
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // margin: const EdgeInsets.only(top: 10.0),
                                      padding: const EdgeInsets.all(15.0),
                                      height: 90,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFrave(
                                              text: 'Layanan Pengiriman',
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                          Divider(),
                                          TextFrave(
                                              text: 'Layanan tidak ditemukan!',
                                              fontSize: 18),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(15.0),
                                      height: 90,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFrave(
                                              text: 'Nama Kurir',
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600),
                                          Divider(),
                                          TextFrave(
                                              text: 'Kurir tidak ditemukan!',
                                              fontSize: 18)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(17.0),
                                      // height: 100,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const TextFrave(
                                                text: 'Harga Ongkir',
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              TextFrave(
                                                text: "0",
                                                fontSize: 19,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          } else if (state is SetOngkir) {
                            kota = state.Kota;
                            estimasi = state.Estimasi;
                            layanankirim = state.LayananKirim;
                            namakurir = state.NamaKurir;
                            ongkir = int.parse(state.Ongkir);
                            print(snapshot.data!.jumlahquantity.toString());
                            BlocProvider.of<TotalBloc>(context).add(
                                PilihTotalEvent(
                                    Total: snapshot.data!.amount.toString(),
                                    Ongkir: (state.Ongkir)));
                            return Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 10.0),
                              height: 470,
                              // height: MediaQuery.of(context).size.height * .5,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  OpsiPengiriman(
                                    jumlahquantity: snapshot
                                        .data!.jumlahquantity
                                        .toString(),
                                    Kota: state.Kota,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10.0),
                                    padding: const EdgeInsets.all(15.0),
                                    height: 90,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFrave(
                                            text: 'Estimasi Pengiriman',
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600),
                                        Divider(),
                                        TextFrave(
                                            text: '${state.Estimasi} Days',
                                            fontSize: 18),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     const TextFrave(
                                        //       text: 'Harga Ongkir',
                                        //       fontSize: 19,
                                        //     ),
                                        //     TextFrave(
                                        //       text: state.Ongkir,
                                        //       fontSize: 19,
                                        //     )
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10.0),
                                    padding: const EdgeInsets.all(15.0),
                                    height: 90,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFrave(
                                            text: 'Layanan Pengiriman',
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600),
                                        Divider(),
                                        TextFrave(
                                            text: '${state.LayananKirim}',
                                            fontSize: 18),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    height: 90,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFrave(
                                            text: 'Nama Kurir',
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600),
                                        Divider(),
                                        TextFrave(
                                            text: '${state.NamaKurir}',
                                            fontSize: 18)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(17.0),
                                    // height: 100,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const TextFrave(
                                              text: 'Harga Ongkir',
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            TextFrave(
                                              text: '\Rp. ${state.Ongkir}',
                                              fontSize: 19,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        })),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 10.0),
                          height: 60,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextFrave(
                                text: ' Harga Order',
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                              TextFrave(
                                // text: '\Rp ${productBloc.state.total.toInt()}',
                                // text: '\eRPe ${keranjang.amount.toStringAsFixed(0)}',
                                text:
                                    '\Rp. ${snapshot.data!.amount.toString()}',
                                fontSize: 19,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 10.0),
                          height: 60,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextFrave(
                                text: 'Total',
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                              BlocBuilder<TotalBloc, TotalState>(
                                  builder: ((context, state) {
                                if (state is TotalInitial) {
                                  return TextFrave(
                                    // text: '\Rp ${productBloc.state.total.toInt()}',
                                    text: "0",
                                    fontSize: 19,
                                  );
                                } else if (state is SetTotal) {
                                  total = int.parse(state.Total);
                                  return TextFrave(
                                    // text: '\Rp ${productBloc.state.total.toInt()}',
                                    text: '\Rp. ${state.Total}',
                                    fontSize: 19,
                                  );
                                } else {
                                  return Container();
                                }
                              }))
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          alignment: Alignment.bottomCenter,
                          child: BtnFrave(
                            text: 'Pay',
                            height: 55,
                            fontSize: 22,
                            width: size.width,
                            onPressed: () {
                              BlocProvider.of<OngkirBloc>(context)
                                  .add(DeleteOngkirEvent());
                              BlocProvider.of<TotalBloc>(context)
                                  .add(DeleteTotalEvent());
                              productBloc.add(OnSaveProductsBuyToDatabaseEvent(
                                  total,
                                  ongkir,
                                  kota,
                                  estimasi,
                                  layanankirim,
                                  namakurir,
                                  snapshot.data!.uidKeranjang.toString()));
                            },
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
