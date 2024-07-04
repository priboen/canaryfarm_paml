import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:royal_canary_farm_app/app/modules/chicksdetail/providers/chicksdetail_provider.dart';

import 'app/routes/app_pages.dart';

void main() {
  Get.put(ChicksdetailProvider());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
