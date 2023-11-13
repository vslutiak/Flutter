import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_router.dart';

class RouterWrapper {
  const RouterWrapper({
    required AppRouter router,
    required List<PageRouteInfo<dynamic>> initialRoutes,
  })  : _router = router,
        _initialRoutes = initialRoutes;

  final AppRouter _router;
  final List<PageRouteInfo<dynamic>> _initialRoutes;

  RouterConfig<UrlState> get config => _router.config(initialRoutes: _initialRoutes);
}
