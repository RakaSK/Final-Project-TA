import 'dart:convert';
import 'package:e_commers/Models/Response/response_keranjang1.dart';
import 'package:e_commers/Models/product.dart';
import 'package:e_commers/Models/Response/response_keranjang.dart';
import 'package:e_commers/Models/Response/response_keranjang_details.dart';
import 'package:http/http.dart' as http;
import 'package:e_commers/Helpers/secure_storage_frave.dart';
import 'package:e_commers/Models/Response/response_default.dart';
import 'package:e_commers/Service/urls.dart';

class KeranjangServices {
  Future<ResponseDefault> saveHistoryKeranjang(
      String receipt, String amount, List<ProductCart> products) async {
    final token = await secureStorage.readToken();

    Map<String, dynamic> data = {
      'receipt': receipt,
      'amount': amount,
      'products': products,
      // 'uidProduct': products[0].uidProduct,
      // 'price': products[0].price,
      // 'amount2': products[0].amount,
    };

    final body = json.encode(data);

    // print(body);

    final resp = await http.post(
        Uri.parse('${URLS.urlApi}/product/save-history-keranjang'),
        headers: {'Content-type': 'application/json', 'xxx-token': token!},
        body: body);

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> deleteHistoryKeranjang(
      String uidKeranjangDetails) async {
    final token = await secureStorage.readToken();

    final response = await http.delete(
      Uri.parse(
          '${URLS.urlApi}/product/delete-keranjang/' + uidKeranjangDetails),
      headers: {'Content-type': 'application/json', 'xxx-token': token!},
    );
    return ResponseDefault.fromJson(jsonDecode(response.body));
  }

  Future<ResponseKeranjang> getAllKeranjang() async {
    final token = await secureStorage.readToken();
    // print(token);

    Map<String, dynamic> data = {
      'token': token,
    };

    final body = json.encode(data);
    final response = await http.post(
        Uri.parse('${URLS.urlApi}/product/get-all-keranjang-products'),
        headers: {'Content-type': 'application/json', 'xxx-token': token!},
        body: body);

    // print(response.body);

    return ResponseKeranjang.fromJson(jsonDecode(response.body));
  }

  Future<Keranjang1> getKeranjangHarga() async {
    final token = await secureStorage.readToken();
    // print(token);

    Map<String, dynamic> data = {
      'token': token,
    };

    final body = json.encode(data);
    final response = await http.post(
        Uri.parse('${URLS.urlApi}/product/get-keranjang-harga-products'),
        headers: {'Content-type': 'application/json', 'xxx-token': token!},
        body: body);

    // print(response.body);

    // return responseKeranjang1.fromJson(jsonDecode(response.body));
    return responseKeranjang1FromJson(response.body);
  }

  Future<List<KeranjangDetails>> getKeranjangDetails(
      String uidKeranjang) async {
    final token = await secureStorage.readToken();

    final response = await http.get(
      Uri.parse('${URLS.urlApi}/product/get-keranjang-details/' + uidKeranjang),
      headers: {'Content-type': 'application/json', 'xxx-token': token!},
    );
    return ResponseKeranjangDetails.fromJson(jsonDecode(response.body))
        .keranjangdetails;
  }

  Future<ResponseDefault> changeItem(
      String jenis, String uidKeranjangDetails) async {
    final token = await secureStorage.readToken();
    print("change item $uidKeranjangDetails");
    final resp = await http
        .post(Uri.parse('${URLS.urlApi}/product/change-item'), headers: {
      'Accept': 'application/json',
      'xxx-token': token!
    }, body: {
      'uidKeranjangDetails': uidKeranjangDetails,
      'jenis': jenis,
    });
    print(resp.body);
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }
}

final keranjangServices = KeranjangServices();
