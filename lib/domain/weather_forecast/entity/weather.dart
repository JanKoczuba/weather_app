import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather({
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.icon,
    required this.city,
    required this.dayName,
  });

  final int temp;
  final int minTemp;
  final int maxTemp;
  final String description;
  final String icon;
  final Option<String> city;
  final String dayName;

  @override
  List<Object?> get props => [
        temp,
        minTemp,
        maxTemp,
        description,
        icon,
        city,
        dayName,
      ];
}
