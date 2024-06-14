import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/gender.dart';
import 'package:http/http.dart' as http;

class CanaryController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final TextEditingController nomorRingController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final RxString selectedCanaryType = ''.obs;
  final selectedGender = Gender.jantan.obs;
  File? selectedImage;

  final FlutterSecureStorage storage = FlutterSecureStorage();

  void setDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    dateController.text = formatter.format(date);
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update();
    }
  }

  void saveBird() async {
    isLoading.value = true;

    if (selectedImage == null) {
      Get.snackbar('Error', 'Please select an image',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      final token = await storage.read(key: 'token');
      print('Token retrieved: $token'); // Log for debugging
      if (token == null) {
        Get.snackbar('Error', 'Token not found');
        isLoading.value = false; // Set isLoading to false when there's an error
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/addcanary'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.fields['ring_number'] = nomorRingController.text;
      request.fields['price'] = hargaController.text;
      request.fields['date_of_birth'] = dateController.text;
      request.fields['gender'] = selectedGender.value.name;
      request.fields['canary_type'] = selectedCanaryType.value;
      request.fields['type_description'] = deskripsiController.text;
      request.files
          .add(await http.MultipartFile.fromPath('photo', selectedImage!.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        isLoading.value = false;
        print(response.statusCode); // Log for debugging
        Get.snackbar(
          'Success',
          'Data Induk berhasil di simpan.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        resetForm();
      } else {
        var responseData = await response.stream.bytesToString();
        var decodedData = json.decode(responseData);
        Get.snackbar('Error', decodedData.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        print(decodedData);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi Kesalahan: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(e);
    }
  }

  void resetForm() {
    nomorRingController.clear();
    hargaController.clear();
    dateController.clear();
    deskripsiController.clear();
    selectedCanaryType.value = '';
    selectedGender.value = Gender.jantan;
    selectedImage = null;
    formKey.currentState?.reset();
    update();
  }

  @override
  void onClose() {
    nomorRingController.dispose();
    hargaController.dispose();
    dateController.dispose();
    deskripsiController.dispose();
    super.onClose();
  }
}
