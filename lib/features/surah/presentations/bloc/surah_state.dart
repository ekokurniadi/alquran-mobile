part of 'surah_bloc.dart';

enum SurahStatus {
  initial,
  loading,
  complete,
  failure,
  isSearch,
  saveComplete,
  deleteComplete,
  processing
}

@freezed
class SurahState with _$SurahState {
  const factory SurahState({
    required SurahStatus status,
    required List<SurahEntity> listSurah,
    required List<SurahEntity> listSurahFavorite,
    required String message,
  }) = _SurahState;

  factory SurahState.initial() => const SurahState(
        status: SurahStatus.initial,
        listSurah: [],
        listSurahFavorite: [],
        message: '',
      );
}
