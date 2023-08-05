import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/core/failure.dart';
import 'package:weather_app/domain/weather_forecast/entity/coordinates.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather_forecast.dart';
import 'package:weather_app/infrastructure/weather_forecast/api/weather_forecast_api.dart';
import 'package:weather_app/infrastructure/weather_forecast/repository/api_weather_forecast_repository.dart';

import '../api/fake_weather_forecast_api.dart';
@GenerateNiceMocks([MockSpec<WeatherForecastApi>()])
import 'api_weather_forecast_repository_test.mocks.dart';

void main() {
  const coordinates = Coordinates(latitude: '40.7128', longitude: '-74.0060');
  late ApiWeatherForecastRepository apiWeatherForecastService;
  late WeatherForecastApi mockWeatherForecastApi;
  late FakeWeatherForecastApi fakeWeatherForecastApi;

  setUp(() {
    mockWeatherForecastApi = MockWeatherForecastApi();
    apiWeatherForecastService = ApiWeatherForecastRepository(
      mockWeatherForecastApi,
    );
    fakeWeatherForecastApi = FakeWeatherForecastApi();
  });

  test(
      '''getWeatherData should return WeatherForecast when API calls are successful''',
      () async {
    final responseWeather = fakeWeatherForecastApi.getWeatherData(
      lat: coordinates.latitude,
      lon: coordinates.longitude,
    );
    final responseForecast = fakeWeatherForecastApi.getForecastData(
      lat: coordinates.latitude,
      lon: coordinates.longitude,
      forecastDayCount: 5,
    );

    when(
      mockWeatherForecastApi.getWeatherData(
        lat: coordinates.latitude,
        lon: coordinates.longitude,
      ),
    ).thenAnswer(
      (_) async => responseWeather,
    );
    when(
      mockWeatherForecastApi.getForecastData(
        lat: coordinates.latitude,
        lon: coordinates.longitude,
        forecastDayCount: 5,
      ),
    ).thenAnswer(
      (_) async => responseForecast,
    );

    final result = await apiWeatherForecastService.getWeatherData(coordinates);

    expect(
      result.fold((l) => l, (r) => r),
      equals(
        Right<Failure, WeatherForecast>(
          WeatherForecast(
            todayWeather: Weather(
              temp: 11,
              minTemp: 11,
              maxTemp: 13,
              description: 'overcast clouds',
              icon: '04n',
              city: some('Katowice'),
              dayName: fakeWeatherForecastApi.toDayName(0),
              fullDate: fakeWeatherForecastApi.toFullDate(0),
            ),
            forecast: [
              Weather(
                temp: 11,
                minTemp: 10,
                maxTemp: 11,
                description: 'overcast clouds',
                icon: '04n',
                city: none(),
                dayName: fakeWeatherForecastApi.toDayName(0),
                fullDate: fakeWeatherForecastApi.toFullDate(0),
              ),
              Weather(
                temp: 11,
                minTemp: 10,
                maxTemp: 11,
                description: 'overcast clouds',
                icon: '04n',
                city: none(),
                dayName: fakeWeatherForecastApi.toDayName(1),
                fullDate: fakeWeatherForecastApi.toFullDate(1),
              ),
              Weather(
                temp: 11,
                minTemp: 10,
                maxTemp: 11,
                description: 'overcast clouds',
                icon: '04n',
                city: none(),
                dayName: fakeWeatherForecastApi.toDayName(2),
                fullDate: fakeWeatherForecastApi.toFullDate(2),
              ),
              Weather(
                temp: 11,
                minTemp: 10,
                maxTemp: 11,
                description: 'overcast clouds',
                icon: '04n',
                city: none(),
                dayName: fakeWeatherForecastApi.toDayName(3),
                fullDate: fakeWeatherForecastApi.toFullDate(3),
              ),
              Weather(
                temp: 11,
                minTemp: 10,
                maxTemp: 11,
                description: 'overcast clouds',
                icon: '04n',
                city: none(),
                dayName: fakeWeatherForecastApi.toDayName(4),
                fullDate: fakeWeatherForecastApi.toFullDate(4),
              ),
            ],
          ),
        ).fold(
          (l) => l,
          (r) => r,
        ),
      ),
    );
  });

  test(
    'getWeatherData should return a Failure when an error occurs in API calls',
    () async {
      when(
        mockWeatherForecastApi.getWeatherData(
          lat: coordinates.latitude,
          lon: coordinates.longitude,
        ),
      ).thenThrow(DioException(
        response:
            Response(requestOptions: RequestOptions(path: ''), statusCode: 500),
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: ''),
      ));

      final result =
          await apiWeatherForecastService.getWeatherData(coordinates);

      expect(
        result,
        equals(
          const Left<Failure, WeatherForecast>(
            Failure.serverError(),
          ),
        ),
      );
    },
  );
}
