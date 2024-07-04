import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/modules/canarydetail/providers/canarydetail_provider.dart';
import 'package:royal_canary_farm_app/app/modules/widget/navigation_menu.dart';

class CanarydetailController extends GetxController {
  late BirdParent bird;
  final CanarydetailProvider provider = CanarydetailProvider();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    bird = Get.arguments as BirdParent;
  }

  Future<void> deleteBird() async {
    isLoading(true);
    try {
      await provider.deleteBird(bird.id!);
      Get.snackbar(
        'Berhasil',
        'Data berhasil di hapus',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAll(() => NavigationMenu());
    } catch (e) {
      debugPrint('Error: $e');
      Get.snackbar('Error', 'Failed to delete BirdParent: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  void showDeleteConfirmationDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              deleteBird();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
