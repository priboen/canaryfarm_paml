import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/profile.dart';
import 'package:royal_canary_farm_app/app/modules/widget/navigation_menu.dart';

class ProfileupdateController extends GetxController {
  var isLoading = false.obs;
  var profile = Profile(
    username: '',
    name: '',
    address: '',
    phone: '',
    photo: '',
  ).obs;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  File? selectedImage;
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
        profile.value = Profile.fromMap(responseData);
        nameController.text = profile.value.name;
        addressController.text = profile.value.address;
        phoneController.text = profile.value.phone;
        usernameController.text = profile.value.username;
      } else {
        Get.snackbar('Error', 'Failed to load profile: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  void pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update();
    }
  }

  void updateProfile() async {
    try {
      isLoading(true);
      final token = await storage.read(key: 'token');
      if (token == null) {
        Get.snackbar('Error', 'Token not found');
        isLoading(false);
        return;
      }

      var request =
          http.MultipartRequest('POST', Uri.parse('$url/profile/update'));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['name'] = nameController.text;
      request.fields['address'] = addressController.text;
      request.fields['phone'] = phoneController.text;

      if (selectedImage != null) {
        request.files.add(
            await http.MultipartFile.fromPath('photo', selectedImage!.path));
      }

      final response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Profile updated successfully');
        fetchProfile();
        Get.offAll(() => NavigationMenu());
      } else {
        Get.snackbar('Error', 'Failed to update profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
