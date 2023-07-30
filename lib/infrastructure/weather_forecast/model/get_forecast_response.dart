import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:weather_app/infrastructure/weather_forecast/model/get_weather_response.dart';

part 'get_forecast_response.g.dart';

@JsonSerializable()
class GetForecastResponse extends Equatable {
  const GetForecastResponse({
    required this.forecast,
  });

  factory GetForecastResponse.fromJson(Map<String, dynamic> json) {
    return _$GetForecastResponseFromJson(json);
  }

  @JsonKey(name: 'list')
  final List<ForecastData> forecast;

  @override
  List<Object?> get props => [
        forecast,
      ];
}

@JsonSerializable()
class ForecastData extends Equatable {
  const ForecastData({
    required this.weather,
    required this.temperatureData,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) =>
      _$ForecastDataFromJson(json);

  final List<WeatherData> weather;
  @JsonKey(name: 'main')
  final TemperatureData temperatureData;

  @override
  List<Object?> get props => [
        weather,
        temperatureData,
      ];
}
