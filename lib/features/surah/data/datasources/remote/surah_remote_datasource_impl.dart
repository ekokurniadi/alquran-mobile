import 'package:alquran_mobile/core/constant/app_constant.dart';
import 'package:alquran_mobile/core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:alquran_mobile/core/error/failures.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'surah_remote_datasource.dart';
import 'package:alquran_mobile/features/surah/data/models/surah_model.codegen.dart';

@LazySingleton(as: SurahRemoteDataSource)
class SurahRemoteDataSourceImpl implements SurahRemoteDataSource {
  const SurahRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  @override
  Future<Either<Failures, List<SurahModel>>> getAllSurah(
      NoParams params) async {
    try {
      final listOfSurah = <SurahModel>[];
      final result = await _dio.get(AppConstant.surahUrl);
      for (var surah in result.data) {
        listOfSurah.add(SurahModel.fromJson(surah));
      }
      return right(listOfSurah);
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
