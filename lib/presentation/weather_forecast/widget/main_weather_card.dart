import 'package:flutter/material.dart';
import 'package:weather_app/domain/weather_forecast/entity/weather.dart';
import 'package:weather_app/presentation/resource/app_color.dart';
import 'package:weather_app/presentation/resource/app_text_style.dart';

class MainWeatherCard extends StatelessWidget {
  const MainWeatherCard({
    required this.todayWeather,
    this.cityName,
    super.key,
  });

  final Weather todayWeather;
  final String? cityName;

  @override
  Widget build(BuildContext context) {
    final cityName = this.cityName;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              AppColor.mainWeatherCardGradient1,
              AppColor.mainWeatherCardGradient2,
              AppColor.mainWeatherCardGradient3,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  if (cityName != null)
                    Text(
                      cityName,
                      style: AppTextStyle.mainWeatherCardCityName,
                    ),
                  Image.network(
                    'https://openweathermap.org/img/wn/${todayWeather.icon}@2x.png',
                  ),
                  Text(
                    key: const Key('tempDescription'),
                    '${todayWeather.description}',
                    style: AppTextStyle.mainWeatherCardWeatherDescription,
                  ),
                  Text(
                    key: const Key('tempDate'),
                    '${todayWeather.dayName}, ${todayWeather.fullDate}',
                    style: AppTextStyle.mainWeatherCardWeatherDate,
                  ),
                ],
              ),
              RichText(
                key: const Key('todaysTemperatures'),
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${todayWeather.maxTemp}/',
                      style: AppTextStyle.temperaturePrimary,
                    ),
                    TextSpan(
                      text: '${todayWeather.minTemp}\u2103',
                      style: AppTextStyle.temperatureSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
