import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/string_extension.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather.dart';
import 'package:weather_app/presentation/resource/app_color.dart';
import 'package:weather_app/presentation/resource/app_text_style.dart';

class WeatherForecastCard extends StatelessWidget {
  const WeatherForecastCard({
    required this.forecast,
    super.key,
  });

  final Weather forecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, left: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColor.weatherForecastCardBackground,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              forecast.dayName.makeShortForm(),
              style: AppTextStyle.temperatureForecast,
            ),
            Text(
              forecast.fullDate,
              style: AppTextStyle.mainWeatherCardWeatherDate,
            ),
            Image.network(
              'https://openweathermap.org/img/wn/${forecast.icon}@2x.png',
            ),
            Text(
              '${forecast.maxTemp}\u2103',
              style: AppTextStyle.temperatureSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
