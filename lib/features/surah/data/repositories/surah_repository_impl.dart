import 'package:alquran_mobile/core/usecases/usecases.dart';
import 'package:alquran_mobile/features/surah/data/datasources/local/surah_local_datasource.dart';
import "package:dartz/dartz.dart";
import "package:alquran_mobile/core/error/failures.dart";
import "package:alquran_mobile/features/surah/domain/repositories/surah_repository.dart";
import "package:alquran_mobile/features/surah/data/datasources/remote/surah_remote_datasource.dart";
import "package:alquran_mobile/features/surah/data/models/surah_model.codegen.dart";
import 'package:injectable/injectable.dart';

@LazySingleton(as: SurahRepository)
class SurahRepositoryImpl implements SurahRepository {
  final SurahRemoteDataSource _surahRemoteDataSource;
  final SurahLocalDataSource _surahLocalDataSource;

  const SurahRepositoryImpl({
    required SurahRemoteDataSource surahRemoteDataSource,
    required SurahLocalDataSource surahLocalDataSource,
  })  : _surahRemoteDataSource = surahRemoteDataSource,
        _surahLocalDataSource = surahLocalDataSource;

  @override
  Future<Either<Failures, List<SurahModel>>> getAllSurah(
    NoParams params,
  ) async {
    return await _surahRemoteDataSource.getAllSurah(params);
  }

  @override
  Future<Either<Failures, List<SurahModel>>> getAllFavSurah(NoParams params) async{
    return await _surahLocalDataSource.getAllFavSurah(params);
  }

  @override
  Future<Either<Failures, List<SurahModel>>> saveToFavorite(SurahModel params) async{
    return await _surahLocalDataSource.saveToFavorite(params);
  }

  @override
  Future<Either<Failures, List<SurahModel>>> deleteFavoriteSurah(int params) async{
    return await _surahLocalDataSource.deleteFavoriteSurah(params);
  }
}
