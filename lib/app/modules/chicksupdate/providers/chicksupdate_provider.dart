import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:royal_canary_farm_app/app/data/chicks.dart';

class ChicksupdateProvider extends GetConnect {
  final String baseUrl = '$url/pedigree-list';

  Future<Chicks> updateChicks(int id, Map<String, dynamic> data,
      {XFile? photo}) async {
    final token = await FlutterSecureStorage().read(key: 'token');

    if (photo != null) {
      final uri = Uri.parse('$baseUrl/$id');
      var request = http.MultipartRequest('PUT', uri);

      request.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });

      request.fields
          .addAll(data.map((key, value) => MapEntry(key, value.toString())));

      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        photo.path,
        filename: path.basename(photo.path),
      ));

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return Chicks.fromJson(jsonDecode(responseString)['data']);
      } else {
        throw Exception(
            'Gagal mengubah data anak burung: $responseString + ${response.statusCode}');
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
        return Chicks.fromJson(jsonDecode(response.body)['data']);
      } else {
        print(response.body);
        print(response.statusCode);
        throw Exception(
            'Gagal mengubah data burung: ${response.body} + ${response.statusCode}');
      }
    }
  }
}
