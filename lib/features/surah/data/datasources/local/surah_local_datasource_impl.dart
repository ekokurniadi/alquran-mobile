import 'dart:convert';

import 'package:alquran_mobile/core/constant/app_constant.dart';
import 'package:alquran_mobile/core/usecases/usecases.dart';
import "package:dartz/dartz.dart";
import "package:alquran_mobile/core/error/failures.dart";
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "surah_local_datasource.dart";
import "package:alquran_mobile/features/surah/data/models/surah_model.codegen.dart";

@LazySingleton(as: SurahLocalDataSource)
class SurahLocalDataSourceImpl implements SurahLocalDataSource {
  const SurahLocalDataSourceImpl(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;

  @override
  Future<Either<Failures, List<SurahModel>>> getAllFavSurah(
      NoParams params) async {
    try {
      final listSurah = <SurahModel>[];
      final result = _sharedPreferences.getString(AppConstant.favoriteSurahKey);

      if (result != null) {
        final decodeResult = jsonDecode(result);
        for (var surat in decodeResult) {
          listSurah.add(SurahModel.fromJson(surat));
        }
      }

      return right(listSurah);
    } catch (e) {
      return left(DatabaseFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<SurahModel>>> saveToFavorite(
      SurahModel params) async {
    try {
      final listSurah = <SurahModel>[];
      final result = _sharedPreferences.getString(AppConstant.favoriteSurahKey);

      final decodeResult = jsonDecode(result ?? '[]');

      for (var surat in decodeResult) {
        listSurah.add(SurahModel.fromJson(surat));
      }
      listSurah.removeWhere((element) => element.nomor == params.nomor);
      listSurah.add(params);

      await _sharedPreferences.setString(
        AppConstant.favoriteSurahKey,
        jsonEncode(listSurah),
      );

      return right(listSurah);
    } catch (e) {
      return left(DatabaseFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<SurahModel>>> deleteFavoriteSurah(
      int params) async {
    try {
      final listSurah = <SurahModel>[];
      final result = _sharedPreferences.getString(AppConstant.favoriteSurahKey);

      final decodeResult = jsonDecode(result ?? '[]');

      for (var surat in decodeResult) {
        listSurah.add(SurahModel.fromJson(surat));
      }
      listSurah.removeWhere((element) => element.nomor == params);

       await _sharedPreferences.setString(
        AppConstant.favoriteSurahKey,
        jsonEncode(listSurah),
      );
      
      return right(listSurah);
    } catch (e) {
      return left(DatabaseFailure(errorMessage: e.toString()));
    }
  }
}
