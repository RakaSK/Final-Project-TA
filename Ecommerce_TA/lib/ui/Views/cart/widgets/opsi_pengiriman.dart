import 'package:e_commers/Bloc/cart/cart_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/cart/cek_ongkir_page.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OpsiPengiriman extends StatelessWidget {
  final String Kota;
  final String? jumlahquantity;
  OpsiPengiriman(
      {Key? key,
      this.Kota = 'Masukkan Kota Tujuan!',
      required this.jumlahquantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        height: 90,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextFrave(
                    text: 'Opsi Pengiriman',
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
                GestureDetector(
                    child: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) => (!state.cardActive!)
                            ? const TextFrave(
                                text: 'Tambah',
                                color: Colors.blue,
                                fontSize: 18)
                            : const TextFrave(
                                text: 'Ubah',
                                color: Colors.blue,
                                fontSize: 18)),
                    onTap: () => Navigator.push(
                        context,
                        routeSlide(
                            page: CekOngkir(
                          jumlahquantity: jumlahquantity.toString(),
                        ))))
              ],
            ),
            Divider(),
            const SizedBox(height: 5.0),
            BlocBuilder<CartBloc, CartState>(
                builder: (_, state) => (!state.cardActive!)
                    ? TextFrave(text: Kota, fontSize: 18)
                    : Container())
          ],
        ));
  }
}
