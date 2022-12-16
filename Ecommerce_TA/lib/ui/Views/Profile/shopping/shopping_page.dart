import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Service/pembayaran_services.dart';
import 'package:e_commers/ui/Views/Home/home_page.dart';
import 'package:e_commers/ui/Views/Profile/shopping/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Models/Response/response_order_buy.dart';
import 'package:e_commers/Service/product_services.dart';
import 'package:e_commers/ui/themes/colors_frave.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return await Navigator.push(context, routeSlide(page: HomePage())) ??
          false;
    }

    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          backgroundColor: Color(0xfff5f5f5),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              modalinfovalidasi(
                  context,
                  'Keterangan :\n\nWarna merah berarti admin belum validasi \n',
                  'Warna hijau berarti admin sudah validasi',
                  onPressed: () => Navigator.pop(context));
            },
            child: Icon(Icons.info_outline),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const TextFrave(
                text: 'Dibeli',
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 20),
            centerTitle: true,
            elevation: 0,
            leading: InkWell(
              onTap: () =>
                  Navigator.push(context, routeSlide(page: HomePage())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black)
                ],
              ),
            ),
            // leading: IconButton(
            //   splashRadius: 20,
            //   icon:
            //       const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
            //   onPressed: () => Navigator.pop(context),
            // ),
            actions: [
              TextButton(
                  onPressed: () {
                    modalInfoBank(
                      context,
                      'Transfer pembayaranmu ke No. Rekening di bawah\n\nBNI\nRaka Surya Kusuma\n0836776299',
                      // onPressed: () => Navigator.push(
                      //     context, routeSlide(page: ShoppingPage()))
                      onPressed: () => Navigator.pop(context),
                    );
                  },
                  child: const TextFrave(
                    text: 'Info Bank',
                    color: ColorsFrave.primaryColorFrave,
                    fontSize: 18,
                  ))
            ],
          ),
          body: FutureBuilder<ResponseOrderBuy>(
            future: pembayaranServices.getPurchasedProducts(),
            builder: (_, snapshot) {
              return (!snapshot.hasData)
                  ? const ShimmerFrave()
                  : _DetailsProductsBuy(orderBuy: snapshot.data!);
            },
          ),
        ));
  }
}

class _DetailsProductsBuy extends StatelessWidget {
  // final List<OrderBuy> ordersBuy;
  final ResponseOrderBuy orderBuy;

  const _DetailsProductsBuy({Key? key, required this.orderBuy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return !orderBuy.resp
        ? Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Center(
              child: Text(orderBuy.msg),
            ))
        : Stack(children: [
            Container(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                itemCount: orderBuy.orderBuy.length,
                itemBuilder: (_, i) => InkWell(
                  onTap: () => Navigator.push(
                      context,
                      routeSlide(
                          page: OrderDetailsPage(
                              uidOrder: orderBuy.orderBuy[i].uidOrderBuy
                                  .toString()))),
                  child: Container(
                    // height: 180,
                    height: mediaQuery.size.height * 0.65,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    margin: EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        // color: Colors.white,
                        color: (orderBuy.orderBuy[i].status == '0')
                            ? Colors.red[200]
                            : Colors.green[300]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFrave(
                            text: orderBuy.orderBuy[i].receipt,
                            fontSize: 22,
                            color: ColorsFrave.primaryColorFrave,
                            fontWeight: FontWeight.w500),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextFrave(
                                text: 'Nama ',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            TextFrave(
                                text: orderBuy.orderBuy[i].users, fontSize: 18),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextFrave(
                                text: 'Email ',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            TextFrave(
                                text: orderBuy.orderBuy[i].email, fontSize: 18),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextFrave(
                                text: 'Tanggal ',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            TextFrave(
                                text: orderBuy
                                        .orderBuy[i].createdAt.day
                                        .toString() +
                                    "-" +
                                    orderBuy.orderBuy[i].createdAt.month
                                        .toString() +
                                    "-" +
                                    orderBuy.orderBuy[i].createdAt.year
                                        .toString() +
                                    " " +
                                    orderBuy.orderBuy[i].createdAt.hour
                                        .toString() +
                                    ":" +
                                    orderBuy.orderBuy[i].createdAt.minute
                                        .toString(),
                                fontSize: 18),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextFrave(
                                text: 'Kota Tujuan',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            TextFrave(
                                text: '${orderBuy.orderBuy[i].kota_tujuan}',
                                fontSize: 18),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // children: [
                          //   const TextFrave(
                          //       text: 'Alamat Pengiriman',
                          //       fontSize: 18,
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.w500),
                          //   TextFrave(text: '${ordersBuy[i].address}', fontSize: 20),
                          // ],
                          children: <Widget>[
                            const TextFrave(
                                text: 'Alamat Pengiriman',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            Flexible(
                              child: new Text(
                                '${orderBuy.orderBuy[i].address}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  // letterSpacing: 2,
                                  // wordSpacing: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextFrave(
                                text: 'Estimasi Pengiriman',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            TextFrave(
                              text: '${orderBuy.orderBuy[i].estimasi} \Days',
                              fontSize: 18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const TextFrave(
                                text: 'Layanan Pengiriman',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            Flexible(
                              child: new Text(
                                '${orderBuy.orderBuy[i].layanankirim}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  // letterSpacing: 2,
                                  // wordSpacing: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextFrave(
                                text: 'Nama Kurir',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            TextFrave(
                              text: '${orderBuy.orderBuy[i].namakurir}',
                              fontSize: 18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextFrave(
                                text: 'Harga Ongkir',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            TextFrave(
                                text: '\Rp. ${orderBuy.orderBuy[i].ongkir}',
                                fontSize: 18),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextFrave(
                                text: 'Total harga ',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            TextFrave(
                                text: '\Rp. ${orderBuy.orderBuy[i].amount}',
                                fontSize: 18),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // FloatingActionButton(
            //   label: (Icon(Icons.save)),
            //   onPressed: () {},
            // ),
          ]);
  }
}
