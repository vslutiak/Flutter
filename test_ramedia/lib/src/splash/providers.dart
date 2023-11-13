import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_ramedia/core/init_app_services.dart';

part 'providers.g.dart';

enum StartupStateStatus {
  none,
  goodConnection,
  brokenConnection,
}

@riverpod
class SplashState extends _$SplashState {
  @override
  StartupStateStatus build() {
    final value = ref.watch(initAppServicesProvider).value;
    return value ?? StartupStateStatus.none;
  }

  void updateStatus(StartupStateStatus status) {
    state = status;
  }
}
