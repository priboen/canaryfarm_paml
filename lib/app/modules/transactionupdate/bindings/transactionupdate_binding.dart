import 'package:get/get.dart';

import '../controllers/transactionupdate_controller.dart';

class TransactionupdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionupdateController>(
      () => TransactionupdateController(),
    );
  }
}
