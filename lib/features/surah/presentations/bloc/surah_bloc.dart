import 'dart:async';

import 'package:alquran_mobile/core/usecases/usecases.dart';
import 'package:alquran_mobile/features/surah/data/models/surah_model.codegen.dart';
import 'package:alquran_mobile/features/surah/domain/entities/surah_entity.codegen.dart';
import 'package:alquran_mobile/features/surah/domain/usecases/delete_favorite_surah_usecase.dart';
import 'package:alquran_mobile/features/surah/domain/usecases/get_all_favorite_surah_usecase.dart';
import 'package:alquran_mobile/features/surah/domain/usecases/get_all_surah_usecase.dart';
import 'package:alquran_mobile/features/surah/domain/usecases/save_to_favorite_surah_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'surah_event.dart';
part 'surah_state.dart';
part 'surah_bloc.freezed.dart';

@injectable
class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final GetAllSurahUseCase _getAllSurahUseCase;
  final GetAllFavoriteSurahUseCase _getAllFavoriteSurahUseCase;
  final SaveToFavoriteSurahUseCase _saveToFavoriteSurahUseCase;
  final DeleteFavoriteSurahUseCase _deleteFavoriteSurahUseCase;

  SurahBloc(
    this._getAllSurahUseCase,
    this._getAllFavoriteSurahUseCase,
    this._saveToFavoriteSurahUseCase,
    this._deleteFavoriteSurahUseCase,
  ) : super(SurahState.initial()) {
    on<GetAllSurahEvent>(_getAllSurah);
    on<GetAllFavSurahEvent>(_getAllFavSurah);
    on<SaveToFavSurahEvent>(_saveToFav);
    on<DeleteFavoriteSurahEvent>(_deleteFavSurah);
    on<SearchSurahEvent>(
      _searchSurah,
      transformer: debounceRestartable(
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  FutureOr<void> _deleteFavSurah(
    DeleteFavoriteSurahEvent event,
    Emitter<SurahState> emit,
  ) async {
    emit(state.copyWith(status: SurahStatus.processing));

    final result = await _deleteFavoriteSurahUseCase(event.params);

    result.fold((l) {
      emit(state.copyWith(
        status: SurahStatus.failure,
        message: l.errorMessage,
      ));
    }, (r) {
      emit(state.copyWith(
          status: SurahStatus.deleteComplete,
          listSurahFavorite: r.toListEntity(),
          message: 'Delete Favorite Surah Success'));
    });
  }

  FutureOr<void> _getAllSurah(
    GetAllSurahEvent event,
    Emitter<SurahState> emit,
  ) async {
    emit(state.copyWith(status: SurahStatus.loading));

    final result = await _getAllSurahUseCase(NoParams());

    result.fold((l) {
      emit(state.copyWith(
        status: SurahStatus.failure,
        message: l.errorMessage,
      ));
    }, (r) {
      emit(state.copyWith(
        status: SurahStatus.complete,
        listSurah: r.toListEntity(),
      ));
    });
  }

  FutureOr<void> _getAllFavSurah(
    GetAllFavSurahEvent event,
    Emitter<SurahState> emit,
  ) async {
    emit(state.copyWith(status: SurahStatus.loading));

    final result = await _getAllFavoriteSurahUseCase(NoParams());

    result.fold((l) {
      emit(state.copyWith(
        status: SurahStatus.failure,
        message: l.errorMessage,
      ));
    }, (r) {
      emit(state.copyWith(
        status: SurahStatus.complete,
        listSurahFavorite: r.toListEntity(),
      ));
    });
  }

  FutureOr<void> _saveToFav(
    SaveToFavSurahEvent event,
    Emitter<SurahState> emit,
  ) async {
    emit(state.copyWith(status: SurahStatus.processing));
    final result = await _saveToFavoriteSurahUseCase(event.params);

    result.fold((l) {
      emit(state.copyWith(
        status: SurahStatus.failure,
        message: l.errorMessage,
      ));
    }, (r) {
      emit(state.copyWith(
        status: SurahStatus.saveComplete,
        listSurahFavorite: r.toListEntity(),
        message: 'Save Surah to Favorite Success',
      ));
    });
  }

  FutureOr<void> _searchSurah(
    SearchSurahEvent event,
    Emitter<SurahState> emit,
  ) async {
    if (event.query != '') {
      emit(state.copyWith(status: SurahStatus.loading));
      emit(
        state.copyWith(
            status: SurahStatus.isSearch,
            listSurah: state.listSurah
                .where((element) => element.namaLatin.toLowerCase().contains(
                      event.query,
                    ))
                .toList()),
      );
    }
  }

  EventTransformer<Event> debounceRestartable<Event>({
    required Duration duration,
  }) =>
      (event, mapper) => restartable<Event>().call(
            event.debounceTime(duration),
            mapper,
          );
}
