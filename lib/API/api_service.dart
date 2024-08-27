import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sneaker_shoes_app/models/category_model.dart';
import 'package:sneaker_shoes_app/models/data_model.dart';
import 'data_model.dart';

Future<List<DataModel>> fetchProducts() async {
  try {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      return List<DataModel>.from(
          json.decode(response.body).map((x) => DataModel.fromJson(x)));
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    print('Error fetching products: $e');
    rethrow;
  }
}

Future<List<CategoryModel>> fetchCategory() async {
  try {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/categories'));
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      return List<CategoryModel>.from(
          json.decode(response.body).map((x) => CategoryModel.fromJson(x)));
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    print('Error fetching products: $e');
    rethrow;
  }
}
