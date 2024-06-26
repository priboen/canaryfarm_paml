import 'package:get/get.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/modules/canarylist/providers/canarylist_provider.dart';

class CanarylistController extends GetxController {
  var birdsList = <BirdParent>[].obs;
  var isLoading = true.obs;
  final CanarylistProvider service = CanarylistProvider();

  @override
  void onInit() {
    fetchBirds();
    super.onInit();
  }

  Future<void> fetchBirds() async {
    try {
      isLoading(true);
      List<BirdParent> birds = await service.fetchBird();
      birdsList.assignAll(birds);
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
