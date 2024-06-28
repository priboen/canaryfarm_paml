import 'package:get/get.dart';

import '../controllers/chicksupdate_controller.dart';

class ChicksupdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChicksupdateController>(
      () => ChicksupdateController(),
    );
  }
}
