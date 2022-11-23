import 'package:alquran_mobile/core/helpers/style_helper.dart';
import 'package:alquran_mobile/core/helpers/toast_helper.dart';
import 'package:alquran_mobile/features/surah/domain/entities/surah_entity.codegen.dart';
import 'package:alquran_mobile/features/surah/presentations/bloc/surah_bloc.dart';
import 'package:alquran_mobile/features/surah/presentations/pages/favorite_surah_page.dart';
import 'package:alquran_mobile/features/surah/presentations/widgets/surah_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurahPage extends StatelessWidget {
  SurahPage({Key? key}) : super(key: key);

  final TextEditingController _searchSurat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleHelper.primaryColor,
        title: Text(
          'Alquran Mobile',
          style: StyleHelper.regulerTextStyle.copyWith(
            color: StyleHelper.whiteColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const FavoriteSurah(),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text(
                  'Surat Favorite',
                  style: StyleHelper.regulerTextStyle.copyWith(
                    color: StyleHelper.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            BlocBuilder<SurahBloc, SurahState>(
              builder: (context, state) {
                return Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF30304d),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _searchSurat,
                    style: StyleHelper.regulerTextStyle.copyWith(
                      color: StyleHelper.whiteColor,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: state.status == SurahStatus.isSearch
                          ? IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                _searchSurat.clear();
                                context
                                    .read<SurahBloc>()
                                    .add(const GetAllSurahEvent());
                              },
                              icon: Icon(
                                Icons.clear,
                                color: StyleHelper.whiteColor,
                              ),
                            )
                          : IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                context
                                    .read<SurahBloc>()
                                    .add(SearchSurahEvent(_searchSurat.text));
                              },
                              icon: Icon(
                                Icons.search,
                                color: StyleHelper.whiteColor,
                              ),
                            ),
                      hintText: 'Cari Surat ...',
                      hintStyle: StyleHelper.regulerTextStyle.copyWith(
                        color: StyleHelper.whiteColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: StyleHelper.whiteColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: StyleHelper.whiteColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            BlocListener<SurahBloc, SurahState>(
              listener: (context, state) {
                if (state.status == SurahStatus.saveComplete) {
                  ToastHelper.showSuccessToast(state.message);
                } else if (state.status == SurahStatus.failure) {
                  ToastHelper.showErrorToast(state.message);
                }
              },
              child: Flexible(
                child: BlocBuilder<SurahBloc, SurahState>(
                  builder: (context, state) {
                    if (state.status == SurahStatus.initial) {
                      context.read<SurahBloc>().add(const GetAllSurahEvent());
                    }
                    return state.status == SurahStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.listSurah.length,
                            itemBuilder: (context, index) {
                              return SurahCardItem(
                                onTap: () {
                                  context.read<SurahBloc>().add(
                                        SaveToFavSurahEvent(
                                          state.listSurah[index].toModel(),
                                        ),
                                      );
                                },
                                secondaryTap: (){},
                                index: index,
                                surahEntity: state.listSurah[index],
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
