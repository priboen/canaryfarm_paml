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
import 'package:royal_canary_farm_app/app/modules/widget/navigation_menu.dart';

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
    if (selectedImage == null) {
      Get.snackbar(
        'Error',
        'Silakan pilih gambar',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        Get.snackbar('Error', 'Token tidak ditemukan');
        isLoading.value = false;
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
        Get.snackbar(
          'Success',
          'Data Induk berhasil disimpan.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(
          () => const NavigationMenu(),
        );
      } else {
        var responseData = await response.stream.bytesToString();
        var decodedData = json.decode(responseData);
        Get.snackbar('Error', decodedData.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
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
