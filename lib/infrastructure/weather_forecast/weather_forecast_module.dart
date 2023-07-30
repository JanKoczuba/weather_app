import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:weather_app/infrastructure/core/api/network_module.dart';
import 'package:weather_app/infrastructure/weather_forecast/api/weather_forecast_api.dart';

@module
abstract class WeatherForecastModule {
  @LazySingleton()
  WeatherForecastApi provideResolutionApi(
    @Named(baseUrlName) String baseUrl,
    @Named(mainDioName) Dio dio,
  ) {
    return WeatherForecastApi(dio, baseUrl: baseUrl);
  }
}
