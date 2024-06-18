import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/data/gender.dart';
import 'package:royal_canary_farm_app/app/modules/chicks/providers/parent_chicks_provider_provider.dart';

class ChicksController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var males = <BirdParent>[].obs;
  var females = <BirdParent>[].obs;
  var selectedMale = Rxn<BirdParent>();
  var selectedFemale = Rxn<BirdParent>();
  var isLoading = false.obs;
  var isLoadingMales = true.obs;
  var isLoadingFemales = true.obs;
  final TextEditingController nomorRingController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final RxString selectedCanaryType = ''.obs;
  final selectedGender = Gender.jantan.obs;

  File? selectedImage;

  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    fetchMales();
    fetchFemales();
  }

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

  void fetchMales() async {
    try {
      isLoadingMales(true);
      var maleList =
          await ParentChicksProviderProvider.fetchParentsByGender('jantan');
      if (maleList != null) {
        males.value = maleList;
      }
    } finally {
      isLoadingMales(false);
    }
  }

  void fetchFemales() async {
    try {
      isLoadingFemales(true);
      var femaleList =
          await ParentChicksProviderProvider.fetchParentsByGender('betina');
      if (femaleList != null) {
        females.value = femaleList;
      }
    } finally {
      isLoadingFemales(false);
    }
  }

  void saveData() async {
    isLoading.value = true;

    if (selectedImage == null) {
      isLoading.value = false;
      Get.snackbar('Error', 'Please select an image',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    try {
      final token = await storage.read(key: 'token');
      print('Token retrieved: $token');
      if (token == null) {
        Get.snackbar('Error', 'Token not found');
        isLoading.value = false;
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/addPedigree'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.fields['ring_number'] = nomorRingController.text;
      request.fields['date_of_birth'] = dateController.text;
      request.fields['gender'] = selectedGender.value.name;
      request.fields['canary_type'] = selectedCanaryType.value;
      request.fields['type_description'] = deskripsiController.text;
      request.files
          .add(await http.MultipartFile.fromPath('photo', selectedImage!.path));
      request.fields['dadparent_id'] = selectedMale.value!.id.toString();
      request.fields['momparent_id'] = selectedFemale.value!.id.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        isLoading.value = false;
        print(response.statusCode);
        Get.snackbar(
          'Success',
          'Data Anak berhasil di simpan.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        resetForm();
      } else {
        isLoading.value = false;
        var responseData = await response.stream.bytesToString();
        var decodedData = json.decode(responseData);
        Get.snackbar('Error', decodedData.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        print(decodedData);
      }
    } catch (e) {
      isLoading.value = false;
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
    dateController.dispose();
    deskripsiController.dispose();
    super.onClose();
  }
}
