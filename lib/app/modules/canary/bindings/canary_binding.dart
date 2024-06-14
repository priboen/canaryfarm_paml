import 'package:get/get.dart';

import '../controllers/canary_controller.dart';

class CanaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CanaryController>(
      () => CanaryController(),
    );
  }
}
