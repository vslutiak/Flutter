import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_ramedia/core/router/app_router.gr.dart';
import 'package:test_ramedia/src/splash/providers.dart';

@RoutePage()
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashStateProvider, (previous, next) {
      if (next == StartupStateStatus.none) {
        FlutterNativeSplash.remove();
        return;
      }
      if (next == StartupStateStatus.none) {
        return;
      }
      FlutterNativeSplash.remove();
      final splashState = next;

      final nextRoute = switch (splashState) {
        StartupStateStatus.goodConnection => const GameRoute(),
        StartupStateStatus.brokenConnection => const ViewRoute(),
        StartupStateStatus.none => const SplashRoute(),
      };
      context.router.replace(nextRoute);
    });

    return const Scaffold();
  }
}
