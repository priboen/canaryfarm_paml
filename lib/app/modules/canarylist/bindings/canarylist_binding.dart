import 'package:get/get.dart';

import '../controllers/canarylist_controller.dart';

class CanarylistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CanarylistController>(
      () => CanarylistController(),
    );
  }
}
