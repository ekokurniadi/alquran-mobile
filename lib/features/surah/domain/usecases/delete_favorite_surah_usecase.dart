import 'package:alquran_mobile/core/error/failures.dart';
import 'package:alquran_mobile/core/usecases/usecases.dart';
import 'package:alquran_mobile/features/surah/data/models/surah_model.codegen.dart';
import 'package:alquran_mobile/features/surah/domain/repositories/surah_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteFavoriteSurahUseCase extends UseCase<List<SurahModel>, int> {
  final SurahRepository _surahRepository;

  DeleteFavoriteSurahUseCase({
    required SurahRepository surahRepository,
  }) : _surahRepository = surahRepository;

  @override
  Future<Either<Failures, List<SurahModel>>> call(int params) async {
    return await _surahRepository.deleteFavoriteSurah(params);
  }
}
