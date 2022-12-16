import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_commers/Helpers/secure_storage_frave.dart';
import 'package:e_commers/Models/Response/response_categories_home.dart';
import 'package:e_commers/Models/Response/response_default.dart';
import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/Models/Response/response_slide_products.dart';
import 'package:e_commers/Service/urls.dart';

class ProductServices {
  Future<List<SlideProduct>> listProductsHomeCarousel() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/product/get-home-products-carousel'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseSlideProducts.fromJson(jsonDecode(resp.body)).slideProducts;
  }

  Future<List<ListProducts>> listProductsHome() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/product/get-products-home'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseProductsHome.fromJson(jsonDecode(resp.body)).listProducts;
  }

  Future<ResponseDefault> addOrDeleteProductFavorite(String uidProduct) async {
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${URLS.urlApi}/product/like-or-unlike-product'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'uidProduct': uidProduct});
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<List<ListProducts>> allFavoriteProducts() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
      Uri.parse('${URLS.urlApi}/product/get-all-favorite'),
      headers: {'Accept': 'application/json', 'xxx-token': token!},
    );

    return ResponseProductsHome.fromJson(jsonDecode(resp.body)).listProducts;
  }

  Future<List<ListProducts>> getProductsForCategories(String id) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
      Uri.parse('${URLS.urlApi}/product/get-products-for-category/' + id),
      headers: {'Content-type': 'application/json', 'xxx-token': token!},
    );

    return ResponseProductsHome.fromJson(jsonDecode(resp.body)).listProducts;
  }

  Future<ResponseDefault> addNewProduct(String name, String description,
      String stock, String price, String uidCategory, String image) async {
    final token = await secureStorage.readToken();

    var request = http.MultipartRequest(
        'POST', Uri.parse('${URLS.urlApi}/product/add-new-product'))
      ..headers['Accept'] = 'application/json'
      ..headers['xxx-token'] = token!
      ..fields['name'] = name
      ..fields['description'] = description
      ..fields['stock'] = stock
      ..fields['price'] = price
      ..fields['uidCategory'] = uidCategory
      ..files.add(await http.MultipartFile.fromPath('productImage', image));

    final resp = await request.send();
    var data = await http.Response.fromStream(resp);

    return ResponseDefault.fromJson(jsonDecode(data.body));
  }

  Future<ResponseDefault> deleteProduct(String uidProduct) async {
    final token = await secureStorage.readToken();

    final response = await http.delete(
      Uri.parse('${URLS.urlApi}/product/delete-product/' + uidProduct),
      headers: {'Content-type': 'application/json', 'xxx-token': token!},
    );
    return ResponseDefault.fromJson(jsonDecode(response.body));
  }

  Future<ResponseDefault> updateStatusPembayaran(
      String uidOrderBuy, String status) async {
    final token = await secureStorage.readToken();

    final response = await http.put(
        Uri.parse('${URLS.urlApi}/update-status-pembayaran'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'uidOrderBuy': uidOrderBuy, 'status': status});

    return ResponseDefault.fromJson(jsonDecode(response.body));
  }
}

final productServices = ProductServices();
