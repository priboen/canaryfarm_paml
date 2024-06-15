import 'dart:convert';

import 'package:get/get.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:http/http.dart' as http;

class ParentChicksProviderProvider extends GetConnect {
  static Future<List<BirdParent>?> fetchParentsByGender(String gender) async {
    final response = await http.get(Uri.parse('$url/canary-list/$gender'));

    if (response.statusCode == 200) {
      // Periksa apakah respons berisi data dalam bentuk daftar
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] is List) {
        List data = jsonResponse['data'];
        return data.map((parent) => BirdParent.fromJson(parent)).toList();
      } else {
        // Jika respons bukan daftar, lempar kesalahan atau tangani sesuai kebutuhan
        throw TypeError();
      }
    } else {
      // Jika ada kesalahan, return null atau throw exception
      return null;
    }
  }
}
