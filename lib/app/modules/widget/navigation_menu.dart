import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/modules/canary/controllers/canary_controller.dart';
import 'package:royal_canary_farm_app/app/modules/canary/views/canary_view.dart';
import 'package:royal_canary_farm_app/app/modules/canarydetail/controllers/canarydetail_controller.dart';
import 'package:royal_canary_farm_app/app/modules/canarydetail/views/canarydetail_view.dart';
import 'package:royal_canary_farm_app/app/modules/canarylist/controllers/canarylist_controller.dart';
import 'package:royal_canary_farm_app/app/modules/canarylist/views/canarylist_view.dart';
import 'package:royal_canary_farm_app/app/modules/chicks/controllers/chicks_controller.dart';
import 'package:royal_canary_farm_app/app/modules/chicks/views/chicks_view.dart';
import 'package:royal_canary_farm_app/app/modules/chickslist/controllers/chickslist_controller.dart';
import 'package:royal_canary_farm_app/app/modules/chickslist/views/chickslist_view.dart';
import 'package:royal_canary_farm_app/app/modules/home/controllers/home_controller.dart';
import 'package:royal_canary_farm_app/app/modules/home/views/home_view.dart';
import 'package:royal_canary_farm_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:royal_canary_farm_app/app/modules/profile/views/profile_view.dart';
import 'package:royal_canary_farm_app/app/modules/profileupdate/controllers/profileupdate_controller.dart';
import 'package:royal_canary_farm_app/app/modules/profileupdate/views/profileupdate_view.dart';

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
          onDestinationSelected: (index) => controller.onTabChange(index),
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
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CanarylistController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => ChickslistController());
    Get.lazyPut(() => ChicksController());
    Get.lazyPut(() => CanaryController());
    Get.lazyPut(() => CanarydetailController());
    Get.lazyPut(() => ProfileupdateController());
  }

  final screens = [
    const HomeView(),
    CanarylistView(),
    ChickslistView(),
    const ProfileView(),
    CanaryView(),
    ChicksView(),
    ProfileupdateView()
  ];

  void onTabChange(int index) {
    selectedIndex.value = index;
    if (index == 1) {
      final canarylistController = Get.find<CanarylistController>();
      canarylistController.fetchBirds();
    } else if (index == 2) {
      final chickslistController = Get.find<ChickslistController>();
      chickslistController.fetchChicks();
    } else if (index == 6) {
      final profileController = Get.find<ProfileController>();
      profileController.fetchProfile();
    }
  }

  void navigateToDetail(BirdParent bird) {
    Get.to(() => CanarydetailView(), arguments: bird);
  }
}
