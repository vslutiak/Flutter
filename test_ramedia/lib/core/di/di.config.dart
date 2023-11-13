// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:test_ramedia/core/di/app_module.dart' as _i5;
import 'package:test_ramedia/core/router/app_router.dart' as _i3;
import 'package:test_ramedia/core/router/router_wrapper.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i3.AppRouter>(appModule.router);
    gh.lazySingleton<_i4.RouterWrapper>(() => appModule.routerWrapper);
    return this;
  }
}

class _$AppModule extends _i5.AppModule {}
