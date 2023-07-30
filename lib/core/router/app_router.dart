import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/presentation/weather_forecast/page/weather_forecast_page.dart';


part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WeatherForecastRoute.page, initial: true),
  ];
}


@module
abstract class RouterModule {
  @singleton
  AppRouter provideAppRouter() => AppRouter();
}
