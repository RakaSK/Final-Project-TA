import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Models/Response/response_order_details.dart';
import 'package:e_commers/Service/pembayaran_services.dart';
import 'package:e_commers/service/product_services.dart';
import 'package:e_commers/service/urls.dart';
import 'package:e_commers/ui/Views/Profile/shopping/bukti_pembayaran_page.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsPage extends StatelessWidget {
  final String uidOrder;

  const OrderDetailsPage({Key? key, required this.uidOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<OrderDetail>>(
            future: pembayaranServices.getOrderDetails(uidOrder),
            builder: (context, snapshot) => !snapshot.hasData
                ? const ShimmerFrave()
                : _ListOrderDetails(orderDetails: snapshot.data!)),
      ),
    );
  }
}

class _ListOrderDetails extends StatelessWidget {
  final List<OrderDetail> orderDetails;

  const _ListOrderDetails({Key? key, required this.orderDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productBloc = BlocProvider.of<ProductBloc>(context);
    final _keyForm = GlobalKey<FormState>();

    bool sudahbayar = false;
    if (orderDetails[0].bukti_pembayaran != "") {
      sudahbayar = true;
    }

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(
                  left: 5.0,
                  top: 5.0,
                ),
                child: IconButton(
                    splashRadius: 20,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios_new_rounded))),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                itemCount: orderDetails.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            child: TextFrave(
                                text: orderDetails[i].nameProduct.toUpperCase(),
                                fontSize: 19,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 15.0),
                        Row(
                          children: [
                            SizedBox(
                                height: 90,
                                width: 90,
                                child: Image.network(
                                    URLS.baseUrl + orderDetails[i].picture)),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFrave(
                                  text:
                                      'Harga = Rp. ${orderDetails[i].priceawal}',
                                  fontSize: 19,
                                ),
                                const SizedBox(height: 5.0),
                                TextFrave(
                                    text: 'Items = ${orderDetails[i].quantity}',
                                    fontSize: 19),
                                const SizedBox(height: 5.0),
                                TextFrave(
                                  text: 'Total = Rp. ${orderDetails[i].price}',
                                  fontSize: 19,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
            height: 120,
            width: size.width,
            child: Column(
              children: [
                // const SizedBox(height: 10.0),
                sudahbayar
                    ? Container(
                        child: Column(
                        children: [
                          Text(orderDetails[0].bukti_pembayaran,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Roboto')),
                          GestureDetector(
                              onTap: () {
                                pembayaranServices
                                    .deleteBukti(
                                        orderDetails[0].uidOrderBuy.toString())
                                    .then((value) {
                                  modalSuccess(
                                      context, 'Bukti berhasil di hapus',
                                      onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        routeSlide(
                                            page: OrderDetailsPage(
                                                uidOrder: orderDetails[0]
                                                    .uidOrderBuy
                                                    .toString())),
                                        (_) => false);
                                  });
                                });
                              },
                              child: Icon(Icons.delete_sharp)),
                        ],
                      ))
                    : BtnFrave(
                        text: 'Bukti Pembayaran',
                        fontSize: 20,
                        width: size.width,
                        height: 56,
                        border: 15,
                        onPressed: () => Navigator.push(
                            context,
                            routeFade(
                                page: BuktiPembayaranPage(
                                    orderDetails[0].uidOrderBuy.toString()))),
                      ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
