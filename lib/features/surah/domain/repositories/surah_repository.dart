import 'package:alquran_mobile/core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:alquran_mobile/core/error/failures.dart';
import 'package:alquran_mobile/features/surah/data/models/surah_model.codegen.dart';

abstract class SurahRepository {
  Future<Either<Failures, List<SurahModel>>> getAllSurah(NoParams params);
  Future<Either<Failures, List<SurahModel>>> getAllFavSurah(NoParams params);
  Future<Either<Failures, List<SurahModel>>> saveToFavorite(SurahModel params);
  Future<Either<Failures, List<SurahModel>>> deleteFavoriteSurah(int params);
}
