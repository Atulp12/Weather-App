
import 'package:http/http.dart' as http;
import 'package:weather_app/secret.dart';

class WeatherDataProvider{
  
  Future<String> getCurrentWeather(String cityName) async {
    try {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$apiKey'));

          if(res.statusCode != 200){
            throw ('An error occured!!');
          }
      return res.body;
    } catch (e) {
      throw (e.toString());
    }
  }

}

// https://api.openweathermap.org/data/2.5/forecast?q=$NewDelhi&APPID=d1eab31841169efc88cf9f5621a14794