import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/data/profile.dart';

class ProfileProvider {
  Future<Profile> getProfile() async {
    final response = await http.get(Uri.parse('$url/profile'));

    if (response.statusCode == 200) {
      return Profile.fromJson(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

    Future<List<BirdParent>> fetchBird() async {
    final token = await FlutterSecureStorage().read(key: 'token');
    final response = await http.get(
      Uri.parse('$url/canary'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body)['data'];
      return jsonResponse.map((bird) => BirdParent.fromJson(bird)).toList();
    } else {
      throw Exception('Failed to load birds: ${response.body}');
    }
  }
}
