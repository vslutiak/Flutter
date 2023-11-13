import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_router.gr.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final appRouter = AppRouter(navigatorKey: navigatorKey);

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  AppRouter({super.navigatorKey});

  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/splash', page: SplashRoute.page),
    AutoRoute(path: '/game', page: GameRoute.page),
    AutoRoute(path: '/view', page: ViewRoute.page),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();
}
