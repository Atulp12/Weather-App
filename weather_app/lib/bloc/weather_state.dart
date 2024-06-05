part of 'weather_bloc.dart';


sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherFailure extends WeatherState{
  final String error;

  WeatherFailure({required this.error});
}

final class WeatherSuccess extends WeatherState{
  final WeatherDataModel weatherDataModel;

  WeatherSuccess({required this.weatherDataModel});
}

final class WeatherLoading extends WeatherState{}
