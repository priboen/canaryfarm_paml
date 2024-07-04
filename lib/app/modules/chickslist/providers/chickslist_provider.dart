import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/chicks.dart';
import 'package:http/http.dart' as http;

class ChickslistProvider extends GetConnect {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<List<Chicks>> fetchChicks() async {
    final token = await _storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$url/pedigree-list'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['chicks'];
      return data.map((chick) => Chicks.fromJson(chick)).toList();
    } else {
      print(response.body);
      throw Exception('Failed to fetch chicks data');
    }
  }
}
