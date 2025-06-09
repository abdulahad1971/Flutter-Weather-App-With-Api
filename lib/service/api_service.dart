import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/WeatherModel.dart';

class ApiService {
  final String _baseUrl = "http://api.weatherapi.com/v1/forecast.json";
  final String _apiKey = "55987e1df84341b7845153356250806";

  Future<WeatherModel> getWeatherData(String selectText) async {
    final String url = "$_baseUrl?key=$_apiKey&q=$selectText&days=14";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;
      } else {
        throw Exception("❌ No Data Found or Invalid Response");
      }
    } catch (e) {
      print("❌ Error: $e");
      throw Exception(e.toString());
    }
  }
}
