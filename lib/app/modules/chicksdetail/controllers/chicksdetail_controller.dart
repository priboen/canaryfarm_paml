import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/data/chicks.dart';
import 'package:royal_canary_farm_app/app/data/pedigree.dart';
import 'package:royal_canary_farm_app/app/modules/chicksdetail/providers/chicksdetail_provider.dart';
import 'package:royal_canary_farm_app/app/modules/widget/navigation_menu.dart';

class ChicksdetailController extends GetxController {
  late Chicks bird;
  final ChicksdetailProvider provider = Get.find<ChicksdetailProvider>();
  var isLoading = false.obs;

  var pedigrees = <Pedigree>[].obs;
  var maleParent = Pedigree().obs;
  var femaleParent = Pedigree().obs;

  @override
  void onInit() {
    super.onInit();
    bird = Get.arguments as Chicks;
    fetchPedigrees();
  }

  void fetchPedigrees() async {
    try {
      isLoading(true);
      var fetchedPedigrees = await provider.fetchPedigrees(bird.id!);
      pedigrees.assignAll(fetchedPedigrees);

      var malePedigree =
          fetchedPedigrees.firstWhereOrNull((p) => p.relationsId == 1);
      var femalePedigree =
          fetchedPedigrees.firstWhereOrNull((p) => p.relationsId == 2);

      if (malePedigree != null && malePedigree.parent != null) {
        maleParent.value = malePedigree;
      }
      if (femalePedigree != null && femalePedigree.parent != null) {
        femaleParent.value = femalePedigree;
      }
    } catch (e) {
      print("Error in fetchPedigrees: $e");
      Get.snackbar('Error', 'Failed to fetch pedigrees');
    } finally {
      isLoading(false);
    }
  }

  void fetchBird() async {
    isLoading(true);
    try {
      bird = await provider.fetchBird(bird.id!);
    } catch (e) {
      debugPrint('Error: $e');
      Get.snackbar('Error', 'Failed to load bird: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteChicks() async {
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
      Get.snackbar('Error', 'Failed to delete Chicks: $e',
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
              deleteChicks();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
