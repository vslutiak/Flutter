import 'package:injectable/injectable.dart';

import '../router/app_router.dart';
import '../router/app_router.gr.dart';
import '../router/router_wrapper.dart';
import 'di.dart';

@module
abstract class AppModule {
  @singleton
  AppRouter get router => appRouter;

  @lazySingleton
  RouterWrapper get routerWrapper => RouterWrapper(
        router: getIt(),
        initialRoutes: [const SplashRoute()],
      );
}
