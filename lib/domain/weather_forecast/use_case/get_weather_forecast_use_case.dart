import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/core/failure.dart';
import 'package:weather_app/domain/weather_forecast/entity/coordinates.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather_forecast.dart';
import 'package:weather_app/domain/weather_forecast/repository/weather_forecast_repository.dart';

@injectable
class GetWeatherForecastUseCase {
  GetWeatherForecastUseCase(
    this._weatherForecastRepository,
  );

  final WeatherForecastRepository _weatherForecastRepository;

  Future<Either<Failure, WeatherForecast>> execute(Coordinates coordinates) =>
      _weatherForecastRepository.getWeatherData(coordinates);
}
