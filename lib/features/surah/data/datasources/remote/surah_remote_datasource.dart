import 'package:alquran_mobile/core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:alquran_mobile/core/error/failures.dart';
import 'package:alquran_mobile/features/surah/data/models/surah_model.codegen.dart';

abstract class SurahRemoteDataSource {
	Future<Either<Failures,List<SurahModel>>> getAllSurah(NoParams params);
}
