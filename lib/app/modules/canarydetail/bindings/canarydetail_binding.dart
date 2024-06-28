import 'package:get/get.dart';

import '../controllers/canarydetail_controller.dart';

class CanarydetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CanarydetailController>(
      () => CanarydetailController(),
    );
  }
}
