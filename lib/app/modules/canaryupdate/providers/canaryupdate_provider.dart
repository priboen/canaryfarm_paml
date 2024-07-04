import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:path/path.dart' as path;

class CanaryupdateProvider extends GetConnect {
  final String baseUrl = '$url/canary-list';

  Future<BirdParent> updateBird(int id, Map<String, dynamic> data, {XFile? photo}) async {
    final token = await FlutterSecureStorage().read(key: 'token');

    if (photo != null) {
      final uri = Uri.parse('$baseUrl/$id');
      var request = http.MultipartRequest('PUT', uri);

      request.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });

      request.fields.addAll(data.map((key, value) => MapEntry(key, value.toString())));

      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        photo.path,
        filename: path.basename(photo.path),
      ));

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return BirdParent.fromJson(jsonDecode(responseString)['data']);
      } else {
        throw Exception(
            'Gagal mengubah data burung: $responseString + ${response.statusCode}');
      }
    } else {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return BirdParent.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw Exception(
            'Gagal mengubah data burung: ${response.body} + ${response.statusCode}');
      }
    }
  }
}
