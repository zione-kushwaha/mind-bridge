import 'package:flutter/material.dart';
import '/themes/theme_config.dart';
import '/themes/sizes.dart';

class AppDecoration {
  // Background decorations
  static BoxDecoration get background => BoxDecoration(
        color: appTheme.gray50,
      );

  // Fill decorations
  static BoxDecoration get fillBlue => BoxDecoration(
        color: appTheme.blue300,
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: appTheme.gray50,
        border: Border.all(
          color: appTheme.black900.withOpacity(0.95),
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.15),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack900 => BoxDecoration();
  static BoxDecoration get outlineBlue => BoxDecoration(
        color: appTheme.amberA700.withOpacity(0.35),
        border: Border.all(
          color: appTheme.blue300,
          width: 1.h,
        ),
      );

  // Primary decorations
  static BoxDecoration get primary => BoxDecoration();

  // Secondary decorations
  static BoxDecoration get secondary => BoxDecoration(
        color: appTheme.amberA700,
      );
  static BoxDecoration get secondaryBackground => BoxDecoration(
        color: appTheme.gray50,
        border: Border.all(
          color: appTheme.amberA700,
          width: 1.h,
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder20 => BorderRadius.circular(
        20.h,
      );

  // Rounded borders
  static BorderRadius get roundedBorder2 => BorderRadius.circular(
        2.h,
      );
}

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;
