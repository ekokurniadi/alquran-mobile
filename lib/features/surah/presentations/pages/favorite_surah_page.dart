import 'package:alquran_mobile/core/helpers/style_helper.dart';
import 'package:alquran_mobile/core/helpers/toast_helper.dart';
import 'package:alquran_mobile/features/surah/presentations/bloc/surah_bloc.dart';
import 'package:alquran_mobile/features/surah/presentations/widgets/surah_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteSurah extends StatefulWidget {
  const FavoriteSurah({Key? key}) : super(key: key);

  @override
  State<FavoriteSurah> createState() => _FavoriteSurahState();
}

class _FavoriteSurahState extends State<FavoriteSurah> {
  late SurahBloc _surahBloc;

  @override
  void initState() {
    _surahBloc = BlocProvider.of<SurahBloc>(context);
    _surahBloc.add(const GetAllFavSurahEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleHelper.primaryColor,
        title: Text(
          'Surat Favorite',
          style: StyleHelper.regulerTextStyle.copyWith(
            color: StyleHelper.whiteColor,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            BlocListener<SurahBloc, SurahState>(
              listener: (context, state) {
                if (state.status == SurahStatus.deleteComplete) {
                  ToastHelper.showSuccessToast(state.message);
                } else if (state.status == SurahStatus.failure) {
                  ToastHelper.showErrorToast(state.message);
                }
              },
              child: Flexible(
                child: BlocBuilder<SurahBloc, SurahState>(
                  builder: (context, state) {
                    return state.status == SurahStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : state.listSurahFavorite.isEmpty
                            ? Center(
                                child: Text(
                                  'Daftar surat favorit mu masih kosong, yuk tambahin.',
                                  style: StyleHelper.regulerTextStyle.copyWith(
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.listSurahFavorite.length,
                                itemBuilder: (context, index) {
                                  return SurahCardItem(
                                    onTap: () {
                                      context
                                          .read<SurahBloc>()
                                          .add(DeleteFavoriteSurahEvent(
                                            state
                                                .listSurahFavorite[index].nomor,
                                          ));
                                    },
                                    secondaryTap: () {},
                                    index: index,
                                    surahEntity: state.listSurahFavorite[index],
                                    isFavorite: true,
                                  );
                                },
                              );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
