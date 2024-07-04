import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:http/http.dart' as http;

class CanarydetailProvider extends GetConnect {
  Future<List<BirdParent>> fetchBird() async {
    final token = await FlutterSecureStorage().read(key: 'token');
    final response = await http.get(
      Uri.parse('$url/canary-list'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body)['data'];
      return jsonResponse.map((bird) => BirdParent.fromJson(bird)).toList();
    } else {
      throw Exception('Failed to load birds');
    }
  }

  Future<BirdParent> fetchBirdById(String id) async {
    final token = await FlutterSecureStorage().read(key: 'token');
    final response = await http.get(
      Uri.parse('$url/canary-list/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return BirdParent.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load bird detail');
    }
  }

  Future<void> deleteBird(int id) async {
    final token = await FlutterSecureStorage().read(key: 'token');

    final response = await http.delete(
      Uri.parse('$url/canary-list/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Gagal menghapus data burung: ${response.body} + ${response.statusCode}');
    }
  }
}
