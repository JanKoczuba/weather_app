import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/core/processing_container.dart';

import 'package:weather_app/presentation/weather_forecast/bloc/weather_forecast_cubit.dart';

import 'package:weather_app/presentation/weather_forecast/widget/main_weather_card.dart';
import 'package:weather_app/presentation/weather_forecast/widget/weather_forecast_card.dart';

class WeatherContent extends StatelessWidget {
  const WeatherContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherForecastCubit, WeatherForecastState>(
      builder: (context, state) {
        return ProcessingContainer(
          isProcessing: state.isLoading,
          child: state.weatherForecast.fold(
            Container.new,
            (weatherForecast) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MainWeatherCard(
                    todayWeather: weatherForecast.todayWeather,
                    cityName: state.city,
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: weatherForecast.forecast.length,
                      itemBuilder: (context, index) {
                        final forecast = weatherForecast.forecast[index];
                        return WeatherForecastCard(
                          forecast: forecast,
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
