import 'package:flutter/material.dart';
import 'package:weather_app/presentation/resource/app_color.dart';

abstract class AppTextStyle {
  static const mainWeatherCardCityName = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColor.textPrimary,
  );
  static const mainWeatherCardTemperature = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static const mainWeatherCardWeatherDescription = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColor.textPrimary,
  );
  static const mainWeatherCardWeatherDate = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColor.textSecondary,
  );

  static const temperaturePrimary = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    color: AppColor.textPrimary,
  );
  static const temperatureSecondary = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColor.textSecondary,
  );
  static const temperatureForecast = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColor.forecastText,
  );
}
