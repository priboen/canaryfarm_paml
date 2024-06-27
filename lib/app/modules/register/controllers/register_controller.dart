import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/modules/login/views/login_view.dart';

class RegisterController extends GetxController {
  File? selectedImage;
  var isLoading = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update();
    }
  }

  Future<void> register() async {
    if (selectedImage == null) {
      Get.snackbar('Error', 'Please select an image',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Password and confirmation password do not match',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print(passwordController.text);
      return;
    }

    isLoading.value = true;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/register'),
      );

      request.fields['name'] = nameController.text.trim();
      request.fields['username'] = usernameController.text.trim();
      request.fields['password'] = passwordController.text.trim();
      request.fields['password_confirmation'] =
          confirmPasswordController.text.trim();
      request.fields['address'] = addressController.text.trim();
      request.fields['phone'] = phoneController.text.trim();
      request.files
          .add(await http.MultipartFile.fromPath('photo', selectedImage!.path));

      // Log the request fields
      print('Request Fields: ${request.fields}');

      var response = await request.send();
      isLoading.value = false;

      if (response.statusCode == 201) {
        print(response.statusCode);
        Get.snackbar('Sukses', 'Registrasi Berhasil',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.offAll(() => LoginView());
      } else {
        var responseData = await response.stream.bytesToString();
        var decodedData = json.decode(responseData);
        print('Response Data: $decodedData');
        Get.snackbar('Error', decodedData.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
