import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double value;
  final List<Color> colors;

  CustomLinearProgressIndicator({required this.value, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.h),
      child: LinearProgressIndicator(
        value: value,
        valueColor: AlwaysStoppedAnimation<Color>(colors.last),
        backgroundColor: colors.first,
      ),
    );
  }
}
