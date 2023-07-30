import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


@RoutePage()
class WeatherForecastPage extends StatefulWidget {
  const WeatherForecastPage({super.key});

  @override
  State<WeatherForecastPage> createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
