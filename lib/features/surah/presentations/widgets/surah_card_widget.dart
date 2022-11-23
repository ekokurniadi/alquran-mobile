import 'package:alquran_mobile/core/extensions/title_case_extension.dart';
import 'package:alquran_mobile/core/helpers/style_helper.dart';
import 'package:alquran_mobile/features/surah/domain/entities/surah_entity.codegen.dart';
import 'package:flutter/material.dart';

class SurahCardItem extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? secondaryTap;
  final int index;
  final SurahEntity surahEntity;
  final bool isFavorite;
  const SurahCardItem({
    Key? key,
    required this.onTap,
    required this.index,
    required this.surahEntity,
    required this.secondaryTap,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.all(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1}. ${surahEntity.namaLatin}',
                style: StyleHelper.regulerTextStyle.copyWith(
                  color: StyleHelper.primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Visibility(
                          visible: !isFavorite,
                          child: TextButton(
                              onPressed: onTap,
                              child: Text(
                                'Tambah ke Favorite',
                                style: StyleHelper.regulerTextStyle,
                              )),
                        ),
                        Visibility(
                          visible: isFavorite,
                          child: TextButton(
                              onPressed: onTap,
                              child: Text(
                                'Hapus',
                                style: StyleHelper.regulerTextStyle,
                              )),
                        ),
                        const SizedBox(width: 15),
                        TextButton(
                            onPressed: secondaryTap,
                            child: Text(
                              'Baca',
                              style: StyleHelper.regulerTextStyle,
                            )),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          surahEntity.nama,
                          style: StyleHelper.regulerTextStyle.copyWith(
                            color: StyleHelper.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${surahEntity.tempatTurun.toTitleCase()} - ${surahEntity.jumlahAyat}',
                          style: StyleHelper.regulerTextStyle.copyWith(
                            color: StyleHelper.blackColor,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
