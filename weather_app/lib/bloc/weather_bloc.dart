import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherDataFetch>(
      _getCurrentWeather
    );
  }

  void _getCurrentWeather(
      WeatherDataFetch event, Emitter<WeatherState> emit) async {
        emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getCurrentWeather();
      emit(WeatherSuccess(weatherDataModel: weather));
    } catch (e) {
      emit(
        WeatherFailure(
          error: e.toString(),
        ),
      );
    }
  }
}
