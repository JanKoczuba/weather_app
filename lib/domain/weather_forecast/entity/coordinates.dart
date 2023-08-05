import 'package:equatable/equatable.dart';

class Coordinates extends Equatable {
  const Coordinates({
    required this.longitude,
    required this.latitude,
  });

  final String longitude;
  final String latitude;

  @override
  List<Object?> get props => [
        longitude,
        latitude,
      ];
}
