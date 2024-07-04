import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/data/chicks.dart';
import 'package:royal_canary_farm_app/app/data/gender.dart';
import 'package:royal_canary_farm_app/app/modules/chicksupdate/providers/chicksupdate_provider.dart';
import 'package:http/http.dart' as http;
import 'package:royal_canary_farm_app/app/modules/widget/navigation_menu.dart';

class ChicksupdateController extends GetxController {
  late Chicks bird;
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

  final ChicksupdateProvider service = ChicksupdateProvider();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  XFile? newPhoto;

  @override
  void onInit() {
    super.onInit();
    bird = Get.arguments as Chicks;
    nomorRingController.text = bird.ringNumber!;
    dateController.text = bird.dateOfBirth!;
    selectedCanaryType.value = bird.canaryType!;
    selectedGender.value = GenderExtension.fromString(bird.gender!);
  }

  void setDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    dateController.text = formatter.format(date);
  }

  Future<void> pickPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      newPhoto = photo;
    }
  }

  Future<void> updateChicks() async {
    isLoading(true);
    try {
      Chicks updatedBird = Chicks(
        id: bird.id,
        ringNumber: nomorRingController.text,
        photo: bird.photo,
        dateOfBirth: dateController.text,
        gender: selectedGender.value.name,
        canaryType: selectedCanaryType.value,
      );

      Map<String, dynamic> data = updatedBird
          .toMap()
          .map((key, value) => MapEntry(key, value.toString()));

      if (newPhoto == null) {
        data.remove('photo');
      }

      await service.updateChicks(bird.id!, data, photo: newPhoto);
      bird = updatedBird;
      Get.snackbar('Berhasil', 'Data berhasil di ubah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      Get.offAll(() => NavigationMenu());
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Gagal mengubah data : $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}
