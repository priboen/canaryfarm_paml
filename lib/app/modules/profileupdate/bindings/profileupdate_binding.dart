import 'package:get/get.dart';

import '../controllers/profileupdate_controller.dart';

class ProfileupdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileupdateController>(
      () => ProfileupdateController(),
    );
  }
}
