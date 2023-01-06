import 'dart:convert';

import '../model/first-task.model.dart';
import 'package:http/http.dart' as http;

Future<firsttask> fetchProducts() async {
  final response = await http.get(Uri.parse('https://randomuser.me/api'));
  if (response.statusCode == 200) {
    return firsttask.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}
