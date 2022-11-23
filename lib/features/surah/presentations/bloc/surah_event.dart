part of 'surah_bloc.dart';

@freezed
class SurahEvent with _$SurahEvent {
  const factory SurahEvent.getAllSurah() = GetAllSurahEvent;
  const factory SurahEvent.searchSurah(String query) = SearchSurahEvent;
  const factory SurahEvent.getAllFavSurah() = GetAllFavSurahEvent;
  const factory SurahEvent.saveToFavSurah(SurahModel params) =
      SaveToFavSurahEvent;
  const factory SurahEvent.deleteFavSurah(int params) =
      DeleteFavoriteSurahEvent;
}
