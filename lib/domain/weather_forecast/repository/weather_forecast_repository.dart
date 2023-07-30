import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/core/failure.dart';
import 'package:weather_app/domain/weather_forecast/entity/coordinates.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather_forecast.dart';

abstract class WeatherForecastRepository {
  Future<Either<Failure, WeatherForecast>> getWeatherData(
    Coordinates coordinates,
  );
}
