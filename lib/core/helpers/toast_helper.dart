import 'package:alquran_mobile/core/helpers/style_helper.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class ToastHelper {
  const ToastHelper._();

  static Future<void> showSuccessToast(String msg) async {
    showToast(
      msg,
      backgroundColor: Colors.pinkAccent,
      position: ToastPosition.bottom,
      textPadding: const EdgeInsets.all(12),
      textStyle: StyleHelper.regulerTextStyle.copyWith(
        color: StyleHelper.whiteColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static Future<void> showErrorToast(String msg) async {
    showToast(
      msg,
      backgroundColor: Colors.black,
      position: ToastPosition.bottom,
      textPadding: const EdgeInsets.all(12),
      textStyle: StyleHelper.regulerTextStyle.copyWith(
        color: StyleHelper.whiteColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
