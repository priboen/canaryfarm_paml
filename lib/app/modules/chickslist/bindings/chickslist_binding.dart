import 'package:get/get.dart';

import '../controllers/chickslist_controller.dart';

class ChickslistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChickslistController>(
      () => ChickslistController(),
    );
  }
}
