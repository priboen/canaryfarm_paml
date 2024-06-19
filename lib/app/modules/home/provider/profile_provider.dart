import 'package:http/http.dart' as http;
import 'package:royal_canary_farm_app/api/service/constant.dart';
import 'package:royal_canary_farm_app/app/data/profile.dart';

class ProfileProvider {
  Future<Profile> getProfile() async {
    final response = await http.get(Uri.parse('$url/profile'));

    if (response.statusCode == 200) {
      return Profile.fromJson(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
