import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/profile.dart';
import 'package:royal_canary_farm_app/app/routes/app_pages.dart';

class ProfileController extends GetxController {
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
      print('Token retrieved: $token'); // Log for debugging
      if (token == null) {
        Get.snackbar('Error', 'Token not found');
        isLoading(false); // Set isLoading to false when there's an error
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
        print('Response data: $responseData'); // Log for debugging

        profile.value = Profile.fromMap(responseData); // Ensure it matches the data received
      } else {
        Get.snackbar('Error', 'Failed to load profile: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    await storage.delete(key: 'token');
    Get.offAllNamed(Routes.LOGIN);
  }
}
