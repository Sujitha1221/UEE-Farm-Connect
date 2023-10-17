import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Title text style
  static get titleLargeErrorContainer => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeGray200ab => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w700,
      );

      static get titleBlack => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black,
        fontWeight: FontWeight.w300,
      );
      static get titleLargeBluegray100 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray100.withOpacity(0.67),
      );

      static get labelLargePrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.67),
      );

      static get labelLargeGreen90002_1 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.green90002.withOpacity(0.67),
      );

      static get labelLargeGreen900ab => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.green900Ab,
      );
}

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}
