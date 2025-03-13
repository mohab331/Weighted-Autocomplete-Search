import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:weighted_auto_complete_search/utils/enums/toast_type_enum.dart';

class ToastNotifier {
  ToastNotifier.success({
    required this.message,
  }) : toastType = ToastType.success;
  ToastNotifier.error({
    required this.message,
  }) : toastType = ToastType.error;
  ToastNotifier.warning({
    required this.message,
  }) : toastType = ToastType.warning;
  final ToastType toastType;
  final String? message;
  void showToast(
    BuildContext context,
  ) {
    if (message?.isEmpty ?? true) return;
    toastification.dismissAll();
    toastification.show(
      context: context,
      type: _getToastificationType(toastType),
      style: ToastificationStyle.flatColored,
      title: Text(
        message ?? '',
        maxLines: 4,
      ),
      autoCloseDuration: const Duration(
        seconds: 5,
      ),
      alignment: Alignment.bottomCenter,
      showProgressBar: false,
      dragToClose: true,
      closeOnClick: true,
    );
  }

  ToastificationType _getToastificationType(ToastType toastType) {
    switch (toastType) {
      case ToastType.success:
        return ToastificationType.success;
      case ToastType.error:
        return ToastificationType.error;
      default:
        return ToastificationType.warning;
    }
  }
}
