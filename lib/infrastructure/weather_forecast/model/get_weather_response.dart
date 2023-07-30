import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_weather_response.g.dart';

@JsonSerializable()
class GetWeatherResponse extends Equatable {
  const GetWeatherResponse({
    required this.weather,
    required this.city,
    required this.temperatureData,
  });

  factory GetWeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$GetWeatherResponseFromJson(json);

  final List<WeatherData> weather;
  @JsonKey(name: 'name')
  final String city;
  @JsonKey(name: 'main')
  final TemperatureData temperatureData;

  @override
  List<Object?> get props => [
        weather,
        city,
        temperatureData,
      ];
}

@JsonSerializable()
class WeatherData extends Equatable {
  const WeatherData({
    required this.description,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);

  final String description;
  final String icon;

  @override
  List<Object?> get props => [
        description,
        icon,
      ];
}

@JsonSerializable()
class TemperatureData extends Equatable {
  const TemperatureData({
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
  });

  factory TemperatureData.fromJson(Map<String, dynamic> json) =>
      _$TemperatureDataFromJson(json);

  final double temp;
  @JsonKey(name: 'temp_min')
  final double minTemp;
  @JsonKey(name: 'temp_max')
  final double maxTemp;

  @override
  List<Object?> get props => [
        temp,
        minTemp,
        maxTemp,
      ];
}
