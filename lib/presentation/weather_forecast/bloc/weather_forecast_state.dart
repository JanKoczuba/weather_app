part of 'weather_forecast_cubit.dart';

@freezed
class WeatherForecastState with _$WeatherForecastState {
  const factory WeatherForecastState({
    required Option<WeatherForecast> weatherForecast,
    required Option<Failure> failure,
    required bool isLoading,
    String? city,
  }) = _WeatherForecastState;

  factory WeatherForecastState.initial() => WeatherForecastState(
        weatherForecast: none(),
        failure: none(),
        isLoading: false,
      );
}
