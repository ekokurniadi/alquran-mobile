import 'package:alquran_mobile/core/helpers/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio => DioHelper.dio!;
}
