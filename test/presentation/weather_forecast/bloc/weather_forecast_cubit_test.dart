import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/domain/geolocator/geolocation.dart';
import 'package:weather_app/domain/weather_forecast/entity/coordinates.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather_forecast.dart';
import 'package:weather_app/domain/weather_forecast/use_case/get_weather_forecast_use_case.dart';
import 'package:weather_app/presentation/weather_forecast/bloc/weather_forecast_cubit.dart';

import '../../../infrastructure/weather_forecast/api/fake_weather_forecast_api.dart';

class MockGetWeatherForecastUseCase extends Mock
    implements GetWeatherForecastUseCase {}

class MockGeolocation extends Mock implements Geolocation {}

void main() {
  const coordinates = Coordinates(latitude: '40.7128', longitude: '-74.0060');
  final tWeatherForecastState = WeatherForecastState.initial();
  final tWeatherForecastStateWithCoordinates =
      tWeatherForecastState.copyWith(coordinates: some(coordinates));

  late GetWeatherForecastUseCase mockGetWeatherForecastUseCase;
  late Geolocation mockGeolocation;
  late WeatherForecast fakeWeatherForecast;

  setUp(() {
    final fakeWeatherForecastApi = FakeWeatherForecastApi();
    mockGetWeatherForecastUseCase = MockGetWeatherForecastUseCase();
    mockGeolocation = MockGeolocation();
    fakeWeatherForecast = fakeWeatherForecastApi.getWeatherForecast();
  });

  void initGeolocationRequest() {
    when(() => mockGeolocation.getCoordinates())
        .thenAnswer((_) async => coordinates);
  }

  WeatherForecastCubit buildWeatherCubit() {
    return WeatherForecastCubit(
      mockGetWeatherForecastUseCase,
      mockGeolocation,
    );
  }

  group('weather forecast cubit test', () {
    test(
      'initial state test',
      () async {
        initGeolocationRequest();
        expect(
          buildWeatherCubit().state,
          tWeatherForecastState,
        );
        verify(
          () => mockGeolocation.getCoordinates(),
        ).called(1);
      },
    );
    blocTest<WeatherForecastCubit, WeatherForecastState>(
      'After some time initalized state should have coordinates',
      setUp: initGeolocationRequest,
      build: buildWeatherCubit,
      expect: () =>
          <WeatherForecastState>[tWeatherForecastStateWithCoordinates],
      verify: (_) => verify(
        () => mockGeolocation.getCoordinates(),
      ).called(1),
    );
    blocTest<WeatherForecastCubit, WeatherForecastState>(
      'Should return a valid state after calling getWeatherData()',
      setUp: () {
        initGeolocationRequest();
        when(
          () => mockGetWeatherForecastUseCase.execute(coordinates),
        ).thenAnswer(
          (_) async => Right(fakeWeatherForecast),
        );
      },
      build: buildWeatherCubit,
      act: (cubit) => cubit.getWeatherData(),
      seed: () => tWeatherForecastStateWithCoordinates,
      expect: () => <WeatherForecastState>[
        tWeatherForecastStateWithCoordinates.copyWith(
          isLoading: true,
        ),
        tWeatherForecastStateWithCoordinates.copyWith(
          weatherForecast: some(fakeWeatherForecast),
          isLoading: false,
        ),
      ],
      verify: (_) => verify(
        () => mockGeolocation.getCoordinates(),
      ).called(1),
    );
  });
}
