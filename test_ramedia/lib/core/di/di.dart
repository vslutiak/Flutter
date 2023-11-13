import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:test_ramedia/core/di/di.config.dart';

final getIt = GetIt.instance;

@injectableInit
GetIt configureDependencies({String? env}) {
  return getIt.init(environment: env ?? Environment.prod);
}
