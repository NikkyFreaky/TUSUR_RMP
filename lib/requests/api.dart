import 'package:http/http.dart' as http;
import 'dart:convert';
import 'env.dart';
import '../models/photos.dart';
import '../models/nasa.dart';

class ApiService {
  final String _baseUrl =
      "https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos";
  final String _apiKey = Env.myApiKey;

  Future<List<Photos>> fetchPhotos({int sol = 110}) async {
    final response =
        await http.get(Uri.parse("$_baseUrl?sol=$sol&api_key=$_apiKey"));

    if (response.statusCode == 200) {
      final nasaData = Nasa.fromJson(json.decode(response.body));
      return nasaData.photos!.take(100).toList();
    } else {
      throw Exception("Failed to load photos");
    }
  }
}
