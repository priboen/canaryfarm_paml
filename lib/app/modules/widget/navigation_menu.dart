import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
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
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Beranda"),
            // NavigationDestination(icon: Icon(Iconsax.activity), label: "Item"),
            // NavigationDestination(
            //     icon: Icon(Iconsax.trade), label: "Transaksi"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profil"),
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
    // Initialize ProfileController when the NavigationController is created
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }

  final screens = [
    const HomeView(),
    // const ItemView(),
    // const TransactionView(),
    const ProfileView(),
  ];
}
