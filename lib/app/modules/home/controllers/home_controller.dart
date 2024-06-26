import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/profile.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var isLoading = false.obs;
  var profile = Profile(
    username: '',
    name: '',
    address: '',
    phone: '',
    photo: '',
  ).obs;

  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void fetchProfile() async {
    try {
      isLoading(true);
      final token = await storage.read(key: 'token');
      print('Token retrieved: $token');
      if (token == null) {
        Get.snackbar('Error', 'Token not found');
        isLoading(false);
        return;
      }
      final response = await http.get(
        Uri.parse('$url/profile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');

        profile.value = Profile.fromMap(responseData);
      } else {
        Get.snackbar('Error', 'Failed to load profile: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<int> getBreederId(int userId) async {
    final response = await http.get(
      Uri.parse('$url/profile/$userId'),
      headers: {
        'Authorization': 'Bearer ${await storage.read(key: 'token')}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['breeder_id'];
    } else {
      throw Exception('Failed to load breederId');
    }
  }
}
