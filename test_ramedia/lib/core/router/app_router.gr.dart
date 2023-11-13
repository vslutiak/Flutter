// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:test_ramedia/src/game/game_page.dart' as _i1;
import 'package:test_ramedia/src/splash/splash_page.dart' as _i2;
import 'package:test_ramedia/src/view/view_page.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    GameRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.GamePage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.SplashPage(),
      );
    },
    ViewRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ViewPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.GamePage]
class GameRoute extends _i4.PageRouteInfo<void> {
  const GameRoute({List<_i4.PageRouteInfo>? children})
      : super(
          GameRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.SplashPage]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ViewPage]
class ViewRoute extends _i4.PageRouteInfo<void> {
  const ViewRoute({List<_i4.PageRouteInfo>? children})
      : super(
          ViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ViewRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
