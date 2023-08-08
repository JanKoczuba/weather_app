part of 'weather_forecast_cubit.dart';

@freezed
class WeatherForecastState with _$WeatherForecastState {
  const factory WeatherForecastState({
    required Option<Either<Failure, WeatherForecast>> failureOrWeatherForecast,
    required bool isLoading,
    String? city,
  }) = _WeatherForecastState;

  factory WeatherForecastState.initial() => WeatherForecastState(
        failureOrWeatherForecast: none(),
        isLoading: false,
      );
}
