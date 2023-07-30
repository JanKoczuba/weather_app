import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/infrastructure/weather_forecast/model/get_weather_response.dart';

import '../api/fake_weather_forecast_api.dart';

void main() {
  const json = {
    'coord': {'lon': 19.0783, 'lat': 50.2758},
    'weather': [
      {
        'id': 804,
        'main': 'Clouds',
        'description': 'overcast clouds',
        'icon': '04n'
      }
    ],
    'base': 'stations',
    'main': {
      'temp': 11.86,
      'feels_like': 10.67,
      'temp_min': 11.23,
      'temp_max': 13.54,
      'pressure': 1015,
      'humidity': 60
    },
    'visibility': 10000,
    'wind': {'speed': 1.34, 'deg': 82, 'gust': 2.68},
    'clouds': {'all': 91},
    'dt': 1682971639,
    'sys': {
      'type': 2,
      'id': 265494,
      'country': 'PL',
      'sunrise': 1682911197,
      'sunset': 1682964091
    },
    'timezone': 7200,
    'id': 3085128,
    'name': 'Katowice',
    'cod': 200
  };

  test(
    'should return a valid get weather response model',
    () async {
      final tData = await FakeWeatherForecastApi().getWeatherData(
        lat: '50.2758',
        lon: '19.0783',
      );

      final result = GetWeatherResponse.fromJson(json);

      expect(result, tData);
    },
  );
}
