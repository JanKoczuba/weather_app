import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/core/failure.dart';
import 'package:weather_app/domain/geolocator/geolocation.dart';
import 'package:weather_app/domain/weather_forecast/entity/coordinates.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather_forecast.dart';
import 'package:weather_app/domain/weather_forecast/use_case/get_weather_forecast_use_case.dart';

part 'weather_forecast_cubit.freezed.dart';

part 'weather_forecast_state.dart';

@injectable
class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  WeatherForecastCubit(
    this._getWeatherDataUseCase,
    this._geolocation,
  ) : super(WeatherForecastState.initial());

  final GetWeatherForecastUseCase _getWeatherDataUseCase;
  final Geolocation _geolocation;

  Future<Coordinates> _getCoordinates() async {
    return _geolocation.getCoordinates();
  }

  Future<void> getWeatherData() async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final coordinates = await _getCoordinates();
    final result = await _getWeatherDataUseCase.execute(coordinates);

    emit(state.copyWith(
      failureOrWeatherForecast: some(result),
      isLoading: false,
      city: result.fold(
        (failure) => null,
        (weatherForecast) => weatherForecast.todayWeather.city.fold(
          () => null,
          (a) => a,
        ),
      ),
    ));
  }
}
