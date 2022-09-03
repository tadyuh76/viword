import 'package:flutter/material.dart';
import 'package:viword/constants/breakpoints.dart';

class MaxWidthContainer extends StatelessWidget {
  final Widget child;
  const MaxWidthContainer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: kLayoutMaxWidth,
      ),
      child: child,
    );
  }
}
