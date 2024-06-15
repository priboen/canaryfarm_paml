import 'package:get/get.dart';

import '../controllers/chicks_controller.dart';

class ChicksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChicksController>(
      () => ChicksController(),
    );
  }
}
