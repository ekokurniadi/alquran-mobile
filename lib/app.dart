import 'package:alquran_mobile/core/constant/app_constant.dart';
import 'package:alquran_mobile/core/helpers/dio_helper.dart';
import 'package:alquran_mobile/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  const App._();
  static late SharedPreferences sharedPreferences;
  
  static Future<void> init() async {
    sharedPreferences = getIt<SharedPreferences>();
    DioHelper.initialDio(AppConstant.baseUrl);
    DioHelper.setDioLogger(AppConstant.baseUrl);
  }
}
