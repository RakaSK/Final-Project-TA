import 'dart:convert';
import 'package:e_commers/Models/Response/response_categories_home.dart';
import 'package:http/http.dart' as http;
import 'package:e_commers/Helpers/secure_storage_frave.dart';
import 'package:e_commers/Models/Response/response_default.dart';
import 'package:e_commers/Service/urls.dart';

class CategoryServices {
  Future<List<Categories>> listCategoriesHome() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/category/get-all-categories'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseCategoriesHome.fromJson(jsonDecode(resp.body)).categories;
  }

  Future<List<Categories>> getAllCategories() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/category/get-all-categories'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseCategoriesHome.fromJson(jsonDecode(resp.body)).categories;
  }
  
  Future<ResponseDefault> addNewCategory(String name, String image) async {
    final token = await secureStorage.readToken();

    var request = http.MultipartRequest(
        'POST', Uri.parse('${URLS.urlApi}/category/add-new-category'))
      ..headers['Accept'] = 'application/json'
      ..headers['xxx-token'] = token!
      ..fields['name'] = name
      ..files.add(await http.MultipartFile.fromPath('categoryImage', image));

    final resp = await request.send();
    var data = await http.Response.fromStream(resp);

    return ResponseDefault.fromJson(jsonDecode(data.body));
  }

  Future<ResponseDefault> deleteCategory(String uidCategory) async {
    final token = await secureStorage.readToken();

    final response = await http.delete(
      Uri.parse('${URLS.urlApi}/category/delete-category/' + uidCategory),
      headers: {'Content-type': 'application/json', 'xxx-token': token!},
    );
    return ResponseDefault.fromJson(jsonDecode(response.body));
  }
}

final categoryServices = CategoryServices();
