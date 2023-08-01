import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/core/failure.dart';
import 'package:weather_app/domain/weather_forecast/entity/coordinates.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather_forecast.dart';
import 'package:weather_app/domain/weather_forecast/repository/weather_forecast_repository.dart';
import 'package:weather_app/domain/weather_forecast/use_case/get_weather_forecast_use_case.dart';

import '../../infrastructure/weather_forecast/api/fake_weather_forecast_api.dart';

@GenerateNiceMocks([MockSpec<WeatherForecastRepository>()])
import 'get_weather_forecast_use_case_test.mocks.dart';

void main() {
  const coordinates = Coordinates(
    latitude: '40.7128',
    longitude: '-74.0060',
  );

  late GetWeatherForecastUseCase getWeatherForecastUseCase;
  late MockWeatherForecastRepository mockWeatherForecastRepository;
  late FakeWeatherForecastApi fakeWeatherForecastApi;

  setUp(() {
    mockWeatherForecastRepository = MockWeatherForecastRepository();
    getWeatherForecastUseCase = GetWeatherForecastUseCase(
      mockWeatherForecastRepository,
    );
    fakeWeatherForecastApi = FakeWeatherForecastApi();
  });

  group('weather use case', () {
    test('should return a weather data', () async {
      when(
        mockWeatherForecastRepository.getWeatherData(coordinates),
      ).thenAnswer(
        (_) async => Right(fakeWeatherForecastApi.getWeatherForecast()),
      );
      final result = await getWeatherForecastUseCase.execute(coordinates);

      expect(
        result,
        Right<Failure, WeatherForecast>(
          fakeWeatherForecastApi.getWeatherForecast(),
        ),
      );
    });
    test('should return a failure', () async {
      when(
        mockWeatherForecastRepository.getWeatherData(coordinates),
      ).thenAnswer(
        (_) async => const Left(Failure.notFound()),
      );
      final result = await getWeatherForecastUseCase.execute(coordinates);

      expect(
        result,
        const Left<Failure, WeatherForecast>(Failure.notFound()),
      );
    });
  });
}
