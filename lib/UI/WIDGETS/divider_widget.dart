import 'dart:ui';

import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double? thickness;
  final Color? color;
  final double? indent;
  final double? endIndent;

  CustomDivider({
    this.thickness = 1,
    this.color = const Color(0x4A3C3C43),
    this.indent = 90,
    this.endIndent = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: thickness!,
      indent: indent!,
      endIndent: endIndent!,
    );
  }
}
