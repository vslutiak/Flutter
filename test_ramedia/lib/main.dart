import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import 'core/di/di.dart';
import 'core/router/router_wrapper.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  configureDependencies(env: Environment.prod);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const AppContainer());
}

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return MainApp(
      router: getIt<RouterWrapper>(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    required this.router,
    super.key,
  });

  final RouterWrapper router;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
      routerConfig: router.config,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ProviderScope(
          child: child!,
        );
      });
}
