import 'package:get/get.dart';

import '../controllers/transactionlist_controller.dart';

class TransactionlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionlistController>(
      () => TransactionlistController(),
    );
  }
}
