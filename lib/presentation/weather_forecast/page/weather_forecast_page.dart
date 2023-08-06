import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/di/di.dart';
import 'package:weather_app/presentation/resource/app_color.dart';
import 'package:weather_app/presentation/weather_forecast/bloc/weather_forecast_cubit.dart';
import 'package:weather_app/presentation/weather_forecast/widget/weather_content.dart';

@RoutePage()
class WeatherForecastPage extends StatefulWidget {
  const WeatherForecastPage({super.key});

  @override
  State<WeatherForecastPage> createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherForecastCubit>()..getWeatherData(),
      child: Builder(
        builder: (context) {
          return BlocListener<WeatherForecastCubit, WeatherForecastState>(
            listenWhen: (previous, current) =>
                previous.failure != current.failure,
            listener: (context, state) {
              state.failure.forEach((failure) async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColor.error,
                    content: Text(failure.toString()),
                  ),
                );
              });
            },
            child: SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColor.appBackgroundGradient4,
                              AppColor.appBackgroundGradient1,
                              AppColor.appBackgroundGradient2,
                              AppColor.appBackgroundGradient3,
                              AppColor.appBackgroundGradient4,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topLeft,
                          ),
                        ),
                      ),
                    ),
                    WeatherContent(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
