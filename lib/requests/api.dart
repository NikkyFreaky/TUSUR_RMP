import 'package:http/http.dart' as http;
import 'dart:convert';
import 'env.dart';
import '../models/photos.dart';
import '../models/nasa.dart';

class ApiService {
  final String _baseUrl =
      "https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos";
  final String _apiKey = Env.myApiKey;
  final int _sol = 110;

  Future<List<Photos>> getNasaData() async {
    try {
      final response =
          await http.get(Uri.parse("$_baseUrl?sol=$_sol&api_key=$_apiKey"));

      if (response.statusCode == 200) {
        final nasaData = Nasa.fromJson(json.decode(response.body));
        return nasaData.photos!.toList();
      } else {
        throw "Ошибка: ${response.reasonPhrase}";
      }
    } catch (e) {
      rethrow;
    }
  }
}
