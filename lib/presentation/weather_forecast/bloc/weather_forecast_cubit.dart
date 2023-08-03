import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/geolocator/geolocation.dart';
import 'package:weather_app/domain/weather_forecast/entity/coordinates.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather_forecast.dart';
import 'package:weather_app/domain/weather_forecast/use_case/get_weather_forecast_use_case.dart';

import '../../../domain/core/failure.dart';

part 'weather_forecast_cubit.freezed.dart';

part 'weather_forecast_state.dart';

@injectable
class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  WeatherForecastCubit(
    this._getWeatherDataUseCase,
    this.geolocation,
  ) : super(WeatherForecastState.initial());

  final GetWeatherForecastUseCase _getWeatherDataUseCase;
  final Geolocation geolocation;

  Future<Coordinates> _getCoordinates() async {
    return geolocation.getCoordinates();
  }

  Future<void> getWeatherData() async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final coordinates = await _getCoordinates();
    final result = await _getWeatherDataUseCase.execute(coordinates);
    result.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          failure: some(l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          weatherForecast: some(r),
          isLoading: false,
        ),
      ),
    );
  }
}
