import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/infrastructure/weather_forecast/model/get_forecast_response.dart';

import '../api/fake_weather_forecast_api.dart';

void main() {

  const json = {
    'cod': '200',
    'message': 0,
    'cnt': 5,
    'list': [
      {
        'dt': 1682974800,
        'main': {
          'temp': 11.86,
          'feels_like': 10.67,
          'temp_min': 10.41,
          'temp_max': 11.86,
          'pressure': 1015,
          'sea_level': 1015,
          'grnd_level': 985,
          'humidity': 60,
          'temp_kf': 1.45
        },
        'weather': [
          {
            'id': 804,
            'main': 'Clouds',
            'description': 'overcast clouds',
            'icon': '04n'
          }
        ],
        'clouds': {'all': 93},
        'wind': {'speed': 1.71, 'deg': 142, 'gust': 2.9},
        'visibility': 10000,
        'pop': 0,
        'sys': {'pod': 'n'},
        'dt_txt': '2023-05-01 21:00:00'
      },
      {
        'dt': 1682985600,
        'main': {
          'temp': 11.86,
          'feels_like': 10.67,
          'temp_min': 10.41,
          'temp_max': 11.86,
          'pressure': 1015,
          'sea_level': 1015,
          'grnd_level': 985,
          'humidity': 60,
          'temp_kf': 1.45
        },
        'weather': [
          {
            'id': 804,
            'main': 'Clouds',
            'description': 'overcast clouds',
            'icon': '04n'
          }
        ],
        'clouds': {'all': 94},
        'wind': {'speed': 1.62, 'deg': 166, 'gust': 1.86},
        'visibility': 10000,
        'pop': 0,
        'sys': {'pod': 'n'},
        'dt_txt': '2023-05-02 00:00:00'
      },
      {
        'dt': 1682996400,
        'main': {
          'temp': 11.86,
          'feels_like': 10.67,
          'temp_min': 10.41,
          'temp_max': 11.86,
          'pressure': 1015,
          'sea_level': 1015,
          'grnd_level': 985,
          'humidity': 60,
          'temp_kf': 1.45
        },
        'weather': [
          {
            'id': 804,
            'main': 'Clouds',
            'description': 'overcast clouds',
            'icon': '04n'
          }
        ],
        'clouds': {'all': 97},
        'wind': {'speed': 2.48, 'deg': 160, 'gust': 5.73},
        'visibility': 10000,
        'pop': 0,
        'sys': {'pod': 'n'},
        'dt_txt': '2023-05-02 03:00:00'
      },
      {
        'dt': 1683007200,
        'main': {
          'temp': 11.86,
          'feels_like': 10.67,
          'temp_min': 10.41,
          'temp_max': 11.86,
          'pressure': 1015,
          'sea_level': 1015,
          'grnd_level': 985,
          'humidity': 60,
          'temp_kf': 1.45
        },
        'weather': [
          {
            'id': 804,
            'main': 'Clouds',
            'description': 'overcast clouds',
            'icon': '04n'
          }
        ],
        'clouds': {'all': 100},
        'wind': {'speed': 2.93, 'deg': 195, 'gust': 8.04},
        'visibility': 10000,
        'pop': 0,
        'sys': {'pod': 'd'},
        'dt_txt': '2023-05-02 06:00:00'
      },
      {
        'dt': 1683018000,
        'main': {
          'temp': 11.86,
          'feels_like': 10.67,
          'temp_min': 10.41,
          'temp_max': 11.86,
          'pressure': 1015,
          'sea_level': 1015,
          'grnd_level': 985,
          'humidity': 60,
          'temp_kf': 1.45
        },
        'weather': [
          {
            'id': 804,
            'main': 'Clouds',
            'description': 'overcast clouds',
            'icon': '04n'
          }
        ],
        'clouds': {'all': 100},
        'wind': {'speed': 4.83, 'deg': 241, 'gust': 7.83},
        'visibility': 10000,
        'pop': 0.43,
        'rain': {'3h': 0.46},
        'sys': {'pod': 'd'},
        'dt_txt': '2023-05-02 09:00:00'
      }
    ],
    'city': {
      'id': 3085128,
      'name': 'Katowice',
      'coord': {'lat': 50.2758, 'lon': 19.0783},
      'country': 'PL',
      'population': 227295,
      'timezone': 7200,
      'sunrise': 1682911197,
      'sunset': 1682964091
    }
  };

  test(
    'should return a valid get forecast response model',
    () async {
      final tData = await FakeWeatherForecastApi().getForecastData(
        lat: '50.2758',
        lon: '19.0783',
        forecastDayCount: 5,
      );

      final result = GetForecastResponse.fromJson(json);

      expect(result, tData);
    },
  );
}
