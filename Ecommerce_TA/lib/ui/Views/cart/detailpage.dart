import 'dart:convert';

import 'package:e_commers/Bloc/Ongkir/ongkir_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/cart/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final String? kota_asal;
  final String? kota_tujuan;
  final String? berat;
  final String? kurir;
  final String? namakurir;
  final String? order;
  final String? nama_kota_tujuan;

  DetailPage(
      {this.kota_asal,
      this.kota_tujuan,
      this.berat,
      this.kurir,
      this.namakurir,
      this.order,
      this.nama_kota_tujuan});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List _data = [];
  var key = '10cb836f3ab0ef52cad5298b57367723';

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _getData();
  }

  Future _getData() async {
    try {
      print(widget.kota_asal);
      print(widget.kota_tujuan);
      print(widget.berat);
      print(widget.kurir);

      final response = await http.post(
        Uri.parse(
          "https://api.rajaongkir.com/starter/cost",
        ),
        //MENGIRIM PARAMETER
        body: {
          "key": key,
          "origin": widget.kota_asal,
          "destination": widget.kota_tujuan,
          "weight": widget.berat,
          "courier": widget.kurir
        },
      ).then((value) {
        var data = jsonDecode(value.body);

        print(data);

        setState(() {
          _data = data['rajaongkir']['results'][0]['costs'];
        });
      });
    } catch (e) {
      //ERROR
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Cek Ongkir"),
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (_, index) {
          return ListTile(
            onTap: () {
              BlocProvider.of<OngkirBloc>(context).add(PilihOngkirEvent(
                  Ongkir: _data[index]['cost'][0]['value'].toString(),
                  Order: "0",
                  Estimasi: _data[index]['cost'][0]['etd'].toString(),
                  LayananKirim:
                      "${_data[index]['service']}-${_data[index]['description']}",
                  NamaKurir: widget.namakurir!.toString(),
                  Kota: widget.nama_kota_tujuan!.toString()));
              Navigator.push(context, routeSlide(page: CheckOutPage()));
              print(widget.nama_kota_tujuan);
              print(_data[index]['service'] + _data[index]['description']);
              print(widget.namakurir!.toString());
            },
            title: Text("${_data[index]['service']}"),
            subtitle: Text("${_data[index]['description']}"),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Rp. ${_data[index]['cost'][0]['value']}",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                SizedBox(
                  height: 3,
                ),
                Text("${_data[index]['cost'][0]['etd']} Days")
              ],
            ),
          );
        },
      ),
    );
  }
}
