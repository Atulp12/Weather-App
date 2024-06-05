// import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Presentation/widgets/add_info.dart';
import 'package:weather_app/Presentation/widgets/hourly_forecast.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    
    super.initState();
    context.read<WeatherBloc>().add(WeatherDataFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Weather App',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<WeatherBloc>().add(WeatherDataFetch());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherFailure) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is! WeatherSuccess) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = state.weatherDataModel;
          final descp = data.descp;
          final temp = data.temp;
          final windSpeed = data.windSpeed;
          final humidity = data.humidity;
          final pressure = data.pressure;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$temp K',
                                style: const TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              descp == 'Clouds'
                                  ? const Icon(
                                      Icons.cloud,
                                      size: 40,
                                    )
                                  : const Icon(
                                      Icons.sunny,
                                      size: 40,
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                descp.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Weather Forecast',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 135,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, i) {
                      // final time1 =
                      //     DateTime.parse(data['list'][i + 1]['dt_txt']);
                       final hourlyData = data.hourlyData[i];
                      return HourlyForecast(
                        time: DateFormat.Hm().format(hourlyData.dateTime),
                        icon: hourlyData.weatherMain ==
                                'Clouds'
                            ? Icons.cloud
                            : Icons.sunny,
                        temp: hourlyData.temperature,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Additional Information',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AddInfo(
                      icon: Icons.water_drop,
                      text: 'Humidity',
                      value: humidity.toString(),
                    ),
                    AddInfo(
                      icon: Icons.air,
                      text: 'Wind Speed',
                      value: windSpeed.toString(),
                    ),
                    AddInfo(
                      icon: Icons.beach_access,
                      text: 'Pressure',
                      value: pressure.toString(),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
