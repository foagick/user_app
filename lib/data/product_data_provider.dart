import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:user_app/models/product.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://fakestoreapi.com',
    headers: {'Content-Type': 'application/json'},
  ),
);

class ProductDataProvider {
  final String baseUrl = 'https://fakestoreapi.com';
  Future<Product> addProduct(Product product) async {

// final response = await dio.post(
//       "/add",
//       data: product.toJson(),
//       options: Options(
//         headers: {'Content-Type': 'application/json'},
//       ),
//     );

    final response = await http.post(
      // Uri.parse('https://fakestoreapi.com/products'),
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: product.toJson(),
    );
    if (response.statusCode !=200) {
      final decodedBody = jsonDecode(response.body);
      final message = decodedBody['message'] ?? 'Failed to add product';
      throw Exception(message);
    }

    final decodedBody = jsonDecode(response.body);
    return Product.fromJson(decodedBody);
  }
  updateProduct()
  deleteProduct()
  getProduct()
  getProducts()
};