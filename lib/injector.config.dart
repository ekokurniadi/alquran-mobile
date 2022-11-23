// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import 'core/helpers/dio_helper.dart' as _i4;
import 'core/module/network_module.dart' as _i17;
import 'core/module/storage_module.dart' as _i18;
import 'features/surah/data/datasources/local/surah_local_datasource.dart'
    as _i6;
import 'features/surah/data/datasources/local/surah_local_datasource_impl.dart'
    as _i7;
import 'features/surah/data/datasources/remote/surah_remote_datasource.dart'
    as _i8;
import 'features/surah/data/datasources/remote/surah_remote_datasource_impl.dart'
    as _i9;
import 'features/surah/data/repositories/surah_repository_impl.dart' as _i11;
import 'features/surah/domain/repositories/surah_repository.dart' as _i10;
import 'features/surah/domain/usecases/delete_favorite_surah_usecase.dart'
    as _i12;
import 'features/surah/domain/usecases/get_all_favorite_surah_usecase.dart'
    as _i13;
import 'features/surah/domain/usecases/get_all_surah_usecase.dart' as _i14;
import 'features/surah/domain/usecases/save_to_favorite_surah_usecase.dart'
    as _i15;
import 'features/surah/presentations/bloc/surah_bloc.dart'
    as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  final storageModule = _$StorageModule();
  gh.lazySingleton<_i3.Dio>(() => networkModule.dio);
  gh.factory<_i4.DioHelper>(() => _i4.DioHelper());
  await gh.lazySingletonAsync<_i5.SharedPreferences>(
      () => storageModule.sharedPreference,
      preResolve: true);
  gh.lazySingleton<_i6.SurahLocalDataSource>(
      () => _i7.SurahLocalDataSourceImpl(get<_i5.SharedPreferences>()));
  gh.lazySingleton<_i8.SurahRemoteDataSource>(
      () => _i9.SurahRemoteDataSourceImpl(get<_i3.Dio>()));
  gh.lazySingleton<_i10.SurahRepository>(() => _i11.SurahRepositoryImpl(
      surahRemoteDataSource: get<_i8.SurahRemoteDataSource>(),
      surahLocalDataSource: get<_i6.SurahLocalDataSource>()));
  gh.factory<_i12.DeleteFavoriteSurahUseCase>(() =>
      _i12.DeleteFavoriteSurahUseCase(
          surahRepository: get<_i10.SurahRepository>()));
  gh.factory<_i13.GetAllFavoriteSurahUseCase>(() =>
      _i13.GetAllFavoriteSurahUseCase(
          surahRepository: get<_i10.SurahRepository>()));
  gh.factory<_i14.GetAllSurahUseCase>(() =>
      _i14.GetAllSurahUseCase(surahRepository: get<_i10.SurahRepository>()));
  gh.factory<_i15.SaveToFavoriteSurahUseCase>(() =>
      _i15.SaveToFavoriteSurahUseCase(
          surahRepository: get<_i10.SurahRepository>()));
  gh.factory<_i16.SurahBloc>(() => _i16.SurahBloc(
      get<_i14.GetAllSurahUseCase>(),
      get<_i13.GetAllFavoriteSurahUseCase>(),
      get<_i15.SaveToFavoriteSurahUseCase>(),
      get<_i12.DeleteFavoriteSurahUseCase>()));
  return get;
}

class _$NetworkModule extends _i17.NetworkModule {}

class _$StorageModule extends _i18.StorageModule {}
