

import 'dart:convert';

import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherRepository{
  final WeatherDataProvider weatherDataProvider;

  WeatherRepository({required this.weatherDataProvider});

    Future<WeatherDataModel> getCurrentWeather() async {
    try {
      String cityName = 'New Delhi';
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);
      
      final data =  jsonDecode(weatherData);

      return WeatherDataModel.fromMap(data);
    } catch (e) {
      throw (e.toString());
    }
  }

}