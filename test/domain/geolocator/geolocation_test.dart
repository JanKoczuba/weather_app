import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:weather_app/domain/geolocator/geolocation.dart';
import 'package:weather_app/domain/weather_forecast/entity/coordinates.dart';

final _mockPosition = Position(
  latitude: 51.5074,
  longitude: -0.1278,
  timestamp: DateTime.now(),
  altitude: 3000,
  accuracy: 0,
  heading: 0,
  speed: 0,
  speedAccuracy: 0,
);

class MockGeolocator extends Mock
    with MockPlatformInterfaceMixin
    implements GeolocatorPlatform {
  @override
  Future<LocationPermission> requestPermission() =>
      Future.value(LocationPermission.whileInUse);

  @override
  Future<Position> getCurrentPosition({
    LocationSettings? locationSettings,
  }) =>
      Future.value(_mockPosition);
}

void main() {
  late Geolocation geolocation;
  late MockGeolocator mockGeolocator;

  setUp(() {
    geolocation = Geolocation();
    mockGeolocator = MockGeolocator();

    GeolocatorPlatform.instance = mockGeolocator;
  });

  test('Geolocation test', () async {
    final result = await geolocation.getCoordinates();
    const expectedCoordinates = Coordinates(
      latitude: '51.5074',
      longitude: '-0.1278',
    );

    expect(
      Coordinates(
        latitude: result.latitude,
        longitude: result.longitude,
      ),
      expectedCoordinates,
    );
  });
}
