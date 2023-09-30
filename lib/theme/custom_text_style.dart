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
        color: appTheme.gray200Ab,
        fontWeight: FontWeight.w700,
      );
}

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}
