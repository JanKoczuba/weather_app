import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/api_key.dart';

const mainDioName = 'mainDio';
const baseUrlName = 'baseUrl';
const apiKeyName = 'apiKey';

@module
abstract class NetworkModule {
  @Named(baseUrlName)
  @LazySingleton()
  String provideBaseUrl() => 'https://api.openweathermap.org/data/2.5';

  @Named(apiKeyName)
  @LazySingleton()
  String provideApiKey() => key;

  @LazySingleton()
  @Named(mainDioName)
  Dio provideMainDio(
    @Named(baseUrlName) String baseUrl,
    AwesomeDioInterceptor logInterceptor,
  ) {
    final mainDio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        queryParameters: {
          'appId': provideApiKey(),
          'units': 'metric',
        },
      ),
    );
    if (kDebugMode) {
      mainDio.interceptors.add(logInterceptor);
    }

    return mainDio;
  }

  @LazySingleton()
  AwesomeDioInterceptor provideLogInterceptor() {
    return AwesomeDioInterceptor(
      logger: debugPrint,
    );
  }
}
