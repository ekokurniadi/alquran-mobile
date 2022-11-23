import 'package:alquran_mobile/core/error/failures.dart';
import 'package:alquran_mobile/core/usecases/usecases.dart';
import 'package:alquran_mobile/features/surah/data/models/surah_model.codegen.dart';
import 'package:alquran_mobile/features/surah/domain/repositories/surah_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveToFavoriteSurahUseCase extends UseCase<List<SurahModel>, SurahModel> {
  final SurahRepository _surahRepository;

  SaveToFavoriteSurahUseCase({
    required SurahRepository surahRepository,
  }) : _surahRepository = surahRepository;

  @override
  Future<Either<Failures, List<SurahModel>>> call(SurahModel params) async {
    return await _surahRepository.saveToFavorite(params);
  }
}
