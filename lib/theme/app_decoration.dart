import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnInverseSurface => BoxDecoration(
        color: theme.colorScheme.onInverseSurface,
      );

  // Outline decorations
  static BoxDecoration get outlineGreen => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.green900,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder26 => BorderRadius.circular(
        26.h,
      );
  static BorderRadius get roundedBorder48 => BorderRadius.circular(
        48.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
