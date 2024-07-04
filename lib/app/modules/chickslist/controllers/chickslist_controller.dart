import 'package:get/get.dart';
import 'package:royal_canary_farm_app/app/data/chicks.dart';
import 'package:royal_canary_farm_app/app/modules/chickslist/providers/chickslist_provider.dart';

class ChickslistController extends GetxController {
  var isLoading = false.obs;
  var chicksList = <Chicks>[].obs;

  final ChickslistProvider service = ChickslistProvider();
  @override
  void onInit() {
    super.onInit();
    fetchChicks();
  }

  Future<void> fetchChicks() async {
    try {
      isLoading(true);
      var fetchedChicks = await service.fetchChicks();
      chicksList.assignAll(fetchedChicks);
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Failed to fetch data: $e');
    } finally {
      isLoading(false);
    }
  }
}
