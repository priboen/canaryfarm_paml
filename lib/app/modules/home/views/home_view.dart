import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:royal_canary_farm_app/app/modules/profile/views/profile_view.dart';
import 'package:royal_canary_farm_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.PROFILE);
            },
            child: Text("Tes Profile"),
          ),
        ],
      )),
    );
  }
}
