import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/data/chicks.dart';
import 'package:royal_canary_farm_app/app/data/profile.dart';
import 'package:http/http.dart' as http;
import 'package:royal_canary_farm_app/app/modules/canarylist/providers/canarylist_provider.dart';
import 'package:royal_canary_farm_app/app/modules/chickslist/providers/chickslist_provider.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var profile = Profile(
    username: '',
    name: '',
    address: '',
    phone: '',
    photo: '',
  ).obs;
  var birdParents = <BirdParent>[].obs;
  var chickData = <Chicks>[].obs;

  final CanarylistProvider canaryService = CanarylistProvider();
  final ChickslistProvider chickService = ChickslistProvider();

  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchBirdParents();
    fetchChickParents();
  }

  void fetchProfile() async {
    try {
      isLoading(true);
      final token = await storage.read(key: 'token');
      if (token == null) {
        Get.snackbar('Error', 'Token not found');
        isLoading(false);
        return;
      }
      final response = await http.get(
        Uri.parse('$url/profile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        profile.value = Profile.fromMap(responseData);
      } else {
        Get.snackbar('Error', 'Failed to load profile: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchBirdParents() async {
    try {
      isLoading(true);
      List<BirdParent> birds = await canaryService.fetchBird();
      birdParents.assignAll(birds);
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchChickParents() async {
    try {
      isLoading(true);
      List<Chicks> chicks = await chickService.fetchChicks();
      chickData.assignAll(chicks);
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
