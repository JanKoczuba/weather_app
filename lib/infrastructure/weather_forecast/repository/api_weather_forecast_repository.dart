import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/core/failure.dart';
import 'package:weather_app/domain/weather_forecast/entity/coordinates.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather_forecast.dart';
import 'package:weather_app/domain/weather_forecast/repository/weather_forecast_repository.dart';
import 'package:weather_app/infrastructure/core/services/base_api_service.dart';
import 'package:weather_app/infrastructure/weather_forecast/api/weather_forecast_api.dart';
import 'package:weather_app/infrastructure/weather_forecast/model/get_weather_response.dart';

const int _forecastDayCount = 5;

@Injectable(as: WeatherForecastRepository)
class ApiWeatherForecastRepository extends BaseApiService
    implements WeatherForecastRepository {
  ApiWeatherForecastRepository(
    this._api,
  ) : _date = DateTime.now();
  final WeatherForecastApi _api;
  final DateTime _date;

  DateTime _incrementDate(int index) => _date.add(
        Duration(days: index),
      );

  String _toDayName(int index) => DateFormat('EEEE').format(
        _incrementDate(index),
      );

  String _toFullDate(int index) {
    final date = _incrementDate(index);
    final monthName = DateFormat.MMMM().format(date);

    return '${date.day} $monthName';
  }

  Weather _toWeather(
    List<WeatherData> data,
    TemperatureData temperatureData,
    Option<String> city,
    int index,
  ) =>
      Weather(
        temp: temperatureData.temp.toInt(),
        minTemp: temperatureData.minTemp.toInt(),
        maxTemp: temperatureData.maxTemp.toInt(),
        description: data.first.description,
        icon: data.first.icon,
        city: city,
        dayName: _toDayName(index),
        fullDate: _toFullDate(index),
      );

  @override
  Future<Either<Failure, WeatherForecast>> getWeatherData(
    Coordinates coordinates,
  ) =>
      makeRequest(() async {
        final responseWeather = await _api.getWeatherData(
          lat: coordinates.latitude,
          lon: coordinates.longitude,
        );
        final responseForecast = await _api.getForecastData(
          lat: coordinates.latitude,
          lon: coordinates.longitude,
          forecastDayCount: _forecastDayCount,
        );

        final weather = _toWeather(
          responseWeather.weather,
          responseWeather.temperatureData,
          some(responseWeather.city),
          0,
        );

        final forecast = responseForecast.forecast
            .mapIndexed(
              (index, weatherData) => _toWeather(
                weatherData.weather,
                weatherData.temperatureData,
                none(),
                index,
              ),
            )
            .toList();

        return right(
          WeatherForecast(
            todayWeather: weather,
            forecast: forecast,
          ),
        );
      });
}
