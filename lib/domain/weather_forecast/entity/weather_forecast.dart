import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather.dart';

class WeatherForecast extends Equatable {
  const WeatherForecast({
    required this.todayWeather,
    required this.forecast,
  });

  final Weather todayWeather;
  final List<Weather> forecast;

  @override
  List<Object?> get props => [
        todayWeather,
        forecast,
      ];
}
