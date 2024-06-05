// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherDataModel {
  /*  final descp = data['list'][0]['weather'][0]['main'];
          final temp = data['list'][0]['main']['temp'];
          final windSpeed = data['list'][0]['wind']['speed'];
          final humidity = data['list'][0]['main']['humidity'];
          final pressure = data['list'][0]['main']['pressure']; */

  final String descp;
  final double temp;
  final double windSpeed;
  final double humidity;
  final double pressure;
  final List<HourlyData> hourlyData;

  WeatherDataModel({
    required this.descp,
    required this.temp,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
    required this.hourlyData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'descp': descp,
      'temp': temp,
      'windSpeed': windSpeed,
      'humidity': humidity,
      'pressure': pressure,
    };
  }

  factory WeatherDataModel.fromMap(Map<String, dynamic> map) {
    final currentWeather = map['list'][0];
    List<HourlyData> hourlyDataList = [];
    for (var i = 1; i < map['list'].length; i++) {
      hourlyDataList.add(HourlyData.fromJson(map['list'][i]));
    }
    return WeatherDataModel(
      hourlyData: hourlyDataList,
      descp: currentWeather['weather'][0]['main'],
      temp: currentWeather['main']['temp'],
      windSpeed: currentWeather['wind']['speed'],
      humidity: currentWeather['main']['humidity'],
      pressure: currentWeather['main']['pressure'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherDataModel.fromJson(String source) =>
      WeatherDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HourlyData {
  final DateTime dateTime;
  final String weatherMain;
  final double temperature;

  HourlyData(
      {required this.dateTime,
      required this.weatherMain,
      required this.temperature});

  factory HourlyData.fromJson(Map<String, dynamic> map) {
    return HourlyData(
      dateTime: DateTime.parse(map['dt_txt']),
      weatherMain: map['weather'][0]['main'],
      temperature: (map['main']['temp'] as num).toDouble(),
    );
  }
}
/* DateTime.parse(data['list'][i + 1]['dt_txt'])*/