import 'package:alquran_mobile/features/surah/data/models/surah_model.codegen.dart';
import "package:freezed_annotation/freezed_annotation.dart";

part "surah_entity.codegen.freezed.dart";
part "surah_entity.codegen.g.dart";

@freezed
class SurahEntity with _$SurahEntity {
  const factory SurahEntity({
    required int nomor,
    required String nama,
    required String namaLatin,
    required int jumlahAyat,
    required String tempatTurun,
    required String arti,
    required String deskripsi,
    required String audio,
  }) = _SurahEntity;

  factory SurahEntity.fromJson(Map<String, dynamic> json) =>
      _$SurahEntityFromJson(json);
}

extension SurahEntityX on SurahEntity {
  SurahModel toModel() => SurahModel(
        nomor: nomor,
        nama: nama,
        namaLatin: namaLatin,
        jumlahAyat: jumlahAyat,
        tempatTurun: tempatTurun,
        arti: arti,
        deskripsi: deskripsi,
        audio: audio,
      );
}
