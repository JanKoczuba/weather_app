import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather_forecast.dart';
import 'package:weather_app/infrastructure/weather_forecast/api/weather_forecast_api.dart';
import 'package:weather_app/infrastructure/weather_forecast/model/get_forecast_response.dart';
import 'package:weather_app/infrastructure/weather_forecast/model/get_weather_response.dart';

class FakeWeatherForecastApi implements WeatherForecastApi {
  final _delay = Future<void>.delayed(const Duration(seconds: 1));
  final _date = DateTime.now();

  String toDayName(int index) {
    return DateFormat('EEEE').format(
      _date.add(
        Duration(days: index),
      ),
    );
  }

  DateTime _incrementDate(int index) => _date.add(
        Duration(days: index),
      );

  String toFullDate(int index) {
    final date = _incrementDate(index);
    final monthName = DateFormat.MMMM().format(date);

    return '${date.day} $monthName';
  }

  WeatherForecast getWeatherForecast() {
    return WeatherForecast(
      todayWeather: Weather(
        temp: 11,
        minTemp: 11,
        maxTemp: 13,
        description: 'overcast clouds',
        icon: '04n',
        city: some('Katowice'),
        dayName: toDayName(0),
        fullDate: toFullDate(0),
      ),
      forecast: [
        Weather(
          temp: 11,
          minTemp: 10,
          maxTemp: 11,
          description: 'overcast clouds',
          icon: '04n',
          city: none(),
          dayName: toDayName(0),
          fullDate: toFullDate(0),
        ),
        Weather(
          temp: 11,
          minTemp: 10,
          maxTemp: 11,
          description: 'overcast clouds',
          icon: '04n',
          city: none(),
          dayName: toDayName(1),
          fullDate: toFullDate(1),
        ),
        Weather(
          temp: 11,
          minTemp: 10,
          maxTemp: 11,
          description: 'overcast clouds',
          icon: '04n',
          city: none(),
          dayName: toDayName(2),
          fullDate: toFullDate(2),
        ),
        Weather(
          temp: 11,
          minTemp: 10,
          maxTemp: 11,
          description: 'overcast clouds',
          icon: '04n',
          city: none(),
          dayName: toDayName(3),
          fullDate: toFullDate(3),
        ),
        Weather(
          temp: 11,
          minTemp: 10,
          maxTemp: 11,
          description: 'overcast clouds',
          icon: '04n',
          city: none(),
          dayName: toDayName(4),
          fullDate: toFullDate(4),
        ),
      ],
    );
  }

  @override
  Future<GetForecastResponse> getForecastData({
    required String lat,
    required String lon,
    required int forecastDayCount,
  }) async {
    await _delay;
    return const GetForecastResponse(
      forecast: [
        ForecastData(
          weather: [
            WeatherData(description: 'overcast clouds', icon: '04n'),
          ],
          temperatureData: TemperatureData(
            temp: 11.86,
            minTemp: 10.41,
            maxTemp: 11.86,
          ),
        ),
        ForecastData(
          weather: [
            WeatherData(description: 'overcast clouds', icon: '04n'),
          ],
          temperatureData: TemperatureData(
            temp: 11.86,
            minTemp: 10.41,
            maxTemp: 11.86,
          ),
        ),
        ForecastData(
          weather: [
            WeatherData(description: 'overcast clouds', icon: '04n'),
          ],
          temperatureData: TemperatureData(
            temp: 11.86,
            minTemp: 10.41,
            maxTemp: 11.86,
          ),
        ),
        ForecastData(
          weather: [
            WeatherData(description: 'overcast clouds', icon: '04n'),
          ],
          temperatureData: TemperatureData(
            temp: 11.86,
            minTemp: 10.41,
            maxTemp: 11.86,
          ),
        ),
        ForecastData(
          weather: [
            WeatherData(description: 'overcast clouds', icon: '04n'),
          ],
          temperatureData: TemperatureData(
            temp: 11.86,
            minTemp: 10.41,
            maxTemp: 11.86,
          ),
        ),
      ],
    );
  }

  @override
  Future<GetWeatherResponse> getWeatherData({
    required String lat,
    required String lon,
  }) async {
    await _delay;
    return const GetWeatherResponse(
      weather: [
        WeatherData(description: 'overcast clouds', icon: '04n'),
      ],
      city: 'Katowice',
      temperatureData: TemperatureData(
        temp: 11.86,
        minTemp: 11.23,
        maxTemp: 13.54,
      ),
    );
  }
}
