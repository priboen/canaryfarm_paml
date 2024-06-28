import 'package:get/get.dart';

import '../controllers/chicksdetail_controller.dart';

class ChicksdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChicksdetailController>(
      () => ChicksdetailController(),
    );
  }
}
