import 'package:http/http.dart' as http;
import 'dart:convert';
import 'env.dart';

Future<Map<String, dynamic>> getNasaData() async {
  final String _apiKey = Env.myApiKey;
  Uri url = Uri.parse(
      'https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?sol=110&api_key=$_apiKey');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
