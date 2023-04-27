import 'dart:convert';
import 'package:http/http.dart' show get;
import '../model/weather_model.dart';

class WeatherApiClient {
  Future<WeatherModel>? getCurrentWeatherUsingCity(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=9a7ee47c1f34db82b97f9344875f9f55&unit=metric");
    var response = await get(endpoint);
    var body = jsonDecode(response.body);
    final model = WeatherModel.fromJson(body);
    return model;
  }

  Future<WeatherModel>? getCuurrentWeatherUsingLocation(
      double? lat, double? long) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=9a7ee47c1f34db82b97f9344875f9f55&unit=metric");
    var response = await get(endpoint);
    var body = jsonDecode(response.body);
    final model = WeatherModel.fromJson(body);
    return model;
  }
}
