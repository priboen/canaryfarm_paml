import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/data/gender.dart';
import 'package:royal_canary_farm_app/app/modules/canaryupdate/providers/canaryupdate_provider.dart';
import 'package:royal_canary_farm_app/app/modules/widget/navigation_menu.dart';

class CanaryupdateController extends GetxController {
  late BirdParent bird;
  var isLoading = false.obs;

  final selectedGender = Gender.jantan.obs;
  final RxString selectedCanaryType = ''.obs;

  final ringNumberController = TextEditingController();
  final photoController = TextEditingController();
  final priceController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController();
  final canaryTypeController = TextEditingController();
  final typeDescriptionController = TextEditingController();

  final CanaryupdateProvider service = CanaryupdateProvider();
  XFile? newPhoto;

  @override
  void onInit() {
    super.onInit();
    bird = Get.arguments as BirdParent;
    ringNumberController.text = bird.ringNumber!;
    photoController.text = bird.photo!;
    priceController.text = bird.price.toString();
    dateOfBirthController.text = bird.dateOfBirth!;
    genderController.text = bird.gender!;
    selectedCanaryType.value = bird.canaryType!;
    typeDescriptionController.text = bird.typeDescription!;
    selectedGender.value = GenderExtension.fromString(bird.gender!);
  }

  Future<void> pickPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      newPhoto = photo;
    }
  }

  Future<void> updateBird() async {
    isLoading(true);
    try {
      double? price = double.tryParse(priceController.text) ?? 0;
      BirdParent updatedBird = BirdParent(
        id: bird.id,
        ringNumber: ringNumberController.text,
        photo: bird.photo,
        price: price,
        dateOfBirth: dateOfBirthController.text,
        gender: selectedGender.value.name,
        canaryType: selectedCanaryType.value,
        typeDescription: typeDescriptionController.text,
      );

      Map<String, dynamic> data = updatedBird
          .toMap()
          .map((key, value) => MapEntry(key, value.toString()));

      if (newPhoto == null) {
        data.remove('photo');
      }

      await service.updateBird(bird.id!, data, photo: newPhoto);
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
        'Gagal mengubah data induk : $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}
