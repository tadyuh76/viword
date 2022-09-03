import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:viword/constants/breakpoints.dart';
import 'package:viword/constants/colors.dart';
import 'package:viword/utils/color_changer.dart';

class CustomSnackBar extends StatelessWidget {
  final Color backgroundColor;
  final String text;

  const CustomSnackBar({
    Key? key,
    required this.backgroundColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 50,
                alignment: Alignment.center,
                constraints: const BoxConstraints(maxWidth: kLayoutMaxWidth),
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [backgroundColor, darken(backgroundColor, .4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: backgroundColor,
                      blurRadius: 8,
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 30),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(12)),
                  child: SvgPicture.asset(
                    'assets/icons/bubbles.svg',
                    height: 36,
                    width: 36,
                    color: darken(backgroundColor, 0.3),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: -16,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/fail.svg',
                      width: 30,
                      height: 30,
                      color: darken(backgroundColor, 0.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Icon(
                        backgroundColor == kRed ? Icons.close : Icons.check,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
