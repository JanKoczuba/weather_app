import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/core/processing_container.dart';

import 'package:weather_app/presentation/weather_forecast/bloc/weather_forecast_cubit.dart';

class WeatherContent extends StatelessWidget {
  const WeatherContent({
    required this.date,
    super.key,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherForecastCubit, WeatherForecastState>(
      builder: (context, state) {
        return ProcessingContainer(
          isProcessing: state.isLoading,
          child: state.weatherForecast.fold(
            Container.new,
            (weatherForecast) => Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                'https://openweathermap.org/img/wn/${weatherForecast.todayWeather.icon}@2x.png',
                              ),
                              Text(
                                key: const Key('tempDescription'),
                                '${weatherForecast.todayWeather.description}',
                              ),
                            ],
                          ),
                          RichText(
                            key: const Key('tadaysTemperatures'),
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${weatherForecast.todayWeather.maxTemp}/',
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.blueAccent),
                                ),
                                TextSpan(
                                  text:
                                      '${weatherForecast.todayWeather.minTemp}\u2103',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: weatherForecast.forecast.length,
                    itemBuilder: (context, index) {
                      final forecast = weatherForecast.forecast[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(forecast.dayName),
                              Image.network(
                                'https://openweathermap.org/img/wn/${forecast.icon}@2x.png',
                              ),
                              Text(forecast.description),
                              //  const Spacer(),
                              Text(
                                '${forecast.maxTemp}\u2103',
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
