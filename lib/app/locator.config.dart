// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i3;

import '../services/shared_preference_service.dart' as _i4;
import '../services/ThirdPartyServices.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<_i3.BottomSheetService>(
      () => thirdPartyServicesModule.bottomSheetService);
  gh.lazySingleton<_i3.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<_i3.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i4.SharedPreferenceService>(
      () => _i4.SharedPreferenceService());
  gh.lazySingleton<_i3.SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);
  return get;
}

class _$ThirdPartyServicesModule extends _i5.ThirdPartyServicesModule {
  @override
  _i3.BottomSheetService get bottomSheetService => _i3.BottomSheetService();
  @override
  _i3.DialogService get dialogService => _i3.DialogService();
  @override
  _i3.NavigationService get navigationService => _i3.NavigationService();
  @override
  _i3.SnackbarService get snackBarService => _i3.SnackbarService();
}
