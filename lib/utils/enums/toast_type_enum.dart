import 'package:flutter/material.dart';

enum ToastType {
  success(
    color: Colors.green,
  ),
  error(
    color: Colors.red,
  ),
  warning(
    color: Colors.orange,
  );
  final Color color;
  const ToastType({
    required this.color,
  });
}
