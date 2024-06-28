import 'package:get/get.dart';

import '../controllers/canaryupdate_controller.dart';

class CanaryupdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CanaryupdateController>(
      () => CanaryupdateController(),
    );
  }
}
