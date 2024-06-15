import 'package:get/get.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/modules/chicks/providers/parent_chicks_provider_provider.dart';

class ChicksController extends GetxController {
  var males = <BirdParent>[].obs;
  var females = <BirdParent>[].obs;
  var selectedMale = Rxn<BirdParent>();
  var selectedFemale = Rxn<BirdParent>();
  var isLoadingMales = true.obs;
  var isLoadingFemales = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMales();
    fetchFemales();
  }

  void fetchMales() async {
    try {
      isLoadingMales(true);
      var maleList =
          await ParentChicksProviderProvider.fetchParentsByGender('jantan');
      if (maleList != null) {
        males.value = maleList;
      }
    } finally {
      isLoadingMales(false);
    }
  }

  void fetchFemales() async {
    try {
      isLoadingFemales(true);
      var femaleList =
          await ParentChicksProviderProvider.fetchParentsByGender('betina');
      if (femaleList != null) {
        females.value = femaleList;
      }
    } finally {
      isLoadingFemales(false);
    }
  }
}
