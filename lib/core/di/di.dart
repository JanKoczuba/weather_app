import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:weather_app/core/di/di.config.dart';

final getIt = GetIt.instance;

@injectableInit
FutureOr<void> configureDependencies() => getIt.init();
