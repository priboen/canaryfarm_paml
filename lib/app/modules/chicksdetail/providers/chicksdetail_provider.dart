import 'package:get/get.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/data/chicks.dart';
import 'package:royal_canary_farm_app/app/data/pedigree.dart';

class ChicksdetailProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        if (map.containsKey('data') && map['data'] is List) {
          return map['data']
              .map<Pedigree>((item) => Pedigree.fromJson(item))
              .toList();
        } else {
          return Pedigree.fromJson(map);
        }
      } else if (map is List) {
        return map.map<Pedigree>((item) => Pedigree.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'http://10.0.2.2:8000/api';
    print("Base URL : ${httpClient.baseUrl}");
  }

  Future<List<Pedigree>> fetchPedigrees(int chickId) async {
    final url = '/pedigrees/$chickId';
    print("Fetching pedigrees from: ${httpClient.baseUrl}$url");
    final response = await get(url);
    print(
        "Response: ${response.body}"); // Tambahkan log respons untuk debugging
    if (response.status.hasError) {
      print("Error fetching pedigrees: ${response.statusText}");
      throw Exception('Failed to load pedigrees');
    }

    // Mengembalikan hasil decoding langsung
    if (response.body is List<Pedigree>) {
      return response.body;
    } else if (response.body is Map && response.body.containsKey('data')) {
      final data = response.body['data'];
      if (data is List) {
        return data.map<Pedigree>((item) => Pedigree.fromJson(item)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Unexpected response format');
    }
  }

  Future<BirdParent> fetchBirdParent(int parentId) async {
    final url = '/parent/$parentId';
    print("Fetching bird parent from: ${httpClient.baseUrl}$url");
    final response = await get(url);
    if (response.status.hasError) {
      print("Error fetching bird parent: ${response.statusText}");
      throw Exception('Failed to load parent');
    }
    return BirdParent.fromJson(response.body['data']);
  }

  Future<Chicks> fetchBird(int chickId) async {
    final url = '/pedigree-list/$chickId';
    print("Fetching bird from: ${httpClient.baseUrl}$url");
    final response = await get(url);
    if (response.status.hasError) {
      print("Error fetching bird: ${response.statusText}");
      throw Exception('Failed to load bird');
    }
    return Chicks.fromJson(response.body['data']);
  }

  Future<void> deleteBird(int chickId) async {
    final url = '/pedigree-list/$chickId';
    print("Deleting bird from: ${httpClient.baseUrl}$url");
    final response = await delete(url);
    if (response.status.hasError) {
      print("Error deleting bird: ${response.statusText}");
      throw Exception('Failed to delete bird');
    }
  }
}
