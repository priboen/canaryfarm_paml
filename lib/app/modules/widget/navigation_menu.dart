import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:royal_canary_farm_app/app/modules/canary/controllers/canary_controller.dart';
import 'package:royal_canary_farm_app/app/modules/canary/views/canary_view.dart';
import 'package:royal_canary_farm_app/app/modules/canarylist/controllers/canarylist_controller.dart';
import 'package:royal_canary_farm_app/app/modules/canarylist/views/canarylist_view.dart';
import 'package:royal_canary_farm_app/app/modules/chicks/controllers/chicks_controller.dart';
import 'package:royal_canary_farm_app/app/modules/chicks/views/chicks_view.dart';
import 'package:royal_canary_farm_app/app/modules/home/controllers/home_controller.dart';
import 'package:royal_canary_farm_app/app/modules/home/views/home_view.dart';
import 'package:royal_canary_farm_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:royal_canary_farm_app/app/modules/profile/views/profile_view.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.onTabChange(index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              label: "Beranda",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.additem),
              label: "Induk",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.trade),
              label: "Anak",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user),
              label: "Profil",
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  NavigationController() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CanarylistController>(() => CanarylistController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ChicksController>(() => ChicksController());
    Get.lazyPut<CanaryController>(() => CanaryController());
  }

  final screens = [
    const HomeView(),
    CanarylistView(),
    ChicksView(),
    const ProfileView(),
    CanaryView(),
  ];

  void onTabChange(int index) {
    selectedIndex.value = index;
    if (index == 1) {
      final canarylistController = Get.find<CanarylistController>();
      canarylistController.fetchBirds();
    }
  }
}
