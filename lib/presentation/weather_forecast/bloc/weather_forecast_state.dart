part of 'weather_forecast_cubit.dart';

@freezed
class WeatherForecastState with _$WeatherForecastState {
  const factory WeatherForecastState({
    required Option<WeatherForecast> weatherForecast,
    required Option<Coordinates> coordinates,
    required bool isLoading,
  }) = _WeatherForecastState;

  factory WeatherForecastState.initial() => WeatherForecastState(
        weatherForecast: none(),
        coordinates: none(),
        isLoading: false,
      );
}
