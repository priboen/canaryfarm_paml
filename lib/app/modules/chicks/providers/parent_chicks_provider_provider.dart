import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:http/http.dart' as http;

class ParentChicksProviderProvider extends GetConnect {
  static Future<List<BirdParent>?> fetchParentsByGender(String gender) async {
    final token = await FlutterSecureStorage().read(key: 'token');
    final response = await http.get(
      Uri.parse('$url/canary-list/$gender'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] is List) {
        List data = jsonResponse['data'];
        return data.map((parent) => BirdParent.fromJson(parent)).toList();
      } else {
        throw TypeError();
      }
    } else {
      return null;
    }
  }
}
