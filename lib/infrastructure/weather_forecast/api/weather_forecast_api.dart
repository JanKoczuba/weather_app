import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/infrastructure/weather_forecast/model/get_forecast_response.dart';
import 'package:weather_app/infrastructure/weather_forecast/model/get_weather_response.dart';


part 'weather_forecast_api.g.dart';

@RestApi()
abstract class WeatherForecastApi {
  factory WeatherForecastApi(Dio dio, {String baseUrl}) = _WeatherForecastApi;

  @GET('/weather')
  Future<GetWeatherResponse> getWeatherData({
    @Query('lat') required String lat,
    @Query('lon') required String lon,
  });

  @GET('/forecast')
  Future<GetForecastResponse> getForecastData({
    @Query('lat') required String lat,
    @Query('lon') required String lon,
    @Query('cnt') required int forecastDayCount,
  });
}
