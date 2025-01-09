import 'package:flutter/material.dart';
import '/themes/theme_config.dart';
import '/themes/sizes.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeGray90001 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray90001,
      );
  static get bodyLargeWhite9000 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 14.fSize,
      );
  static get bodyLargeBlue300 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blue300,
      );
  static get bodyMediumAmberA700 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.amberA700,
      );
  static get bodyMediumAmberA700_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.amberA700,
      );
  static get bodyMediumWhiteA700 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodyMedium_1 => theme.textTheme.bodyMedium!;
  static get bodyMedium_2 => theme.textTheme.bodyMedium!;
  static get bodySmallAmberA700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.amberA700,
      );
  static get bodySmallBlue300 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blue300,
      );
  static get bodySmallWhite9000 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 8.fSize,
      );
  static get bodySmallBlue50 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blue50,
      );
  static get bodySmallGray90001 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray90001,
        fontSize: 10.fSize,
      );
  static get bodySmallGray900018 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray90001,
        fontSize: 8.fSize,
      );
  // Display text style
  static get displayMediumAmberA700 => theme.textTheme.displayMedium!.copyWith(
        color: appTheme.amberA700,
      );
  static get displayMediumBlue300 => theme.textTheme.displayMedium!.copyWith(
        color: appTheme.blue300,
      );
  // Headline text style
  static get headlineMediumAmberA700 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.amberA700,
      );
  // Title text style
  static get titleLargeBlue300 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blue300,
      );
  static get titleLargeBlue300_1 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blue300,
      );
  static get titleLargeGray900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.gray900,
      );
  static get titleLargeInterGray900 =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.gray900,
        fontSize: 20.fSize,
      );
  static get titleLargeInterGray90020 =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.gray900,
        fontSize: 20.fSize,
      );
}

extension on TextStyle {
  TextStyle get openDyslexic {
    return copyWith(
      fontFamily: 'OpenDyslexic',
    );
  }

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
