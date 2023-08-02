import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import 'package:weather_app/domain/weather_forecast/entity/coordinates.dart';

@lazySingleton
class Geolocation {
  Future<Coordinates> getCoordinates() async {
    await Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    return Coordinates(
      latitude: '${position.latitude}',
      longitude: '${position.longitude}',
    );
  }
}
