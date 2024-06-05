import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Presentation/screens/home_screen.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherDataProvider weatherDataProvider = WeatherDataProvider();
    return RepositoryProvider(
      create: (context) => WeatherRepository(
          weatherDataProvider: weatherDataProvider
      ),
      child: BlocProvider(
        create: (context) => WeatherBloc(context.read<WeatherRepository>()),
        child: MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(useMaterial3: true),
          home: const WeatherScreen(),
        ),
      ),
    );
  }
}
