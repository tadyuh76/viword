import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:viword/widgets/custom_snack_bar.dart';

void showSnackBar({
  required BuildContext context,
  required Color backgroundColor,
  required String text,
  Duration? duration,
}) {
  // prevent spam
  _closeSnackBars(context);
  showTopSnackBar(
    context,
    CustomSnackBar(backgroundColor: backgroundColor, text: text),
    displayDuration: duration ?? const Duration(seconds: 4),
  );
}

void _closeSnackBars(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
}
