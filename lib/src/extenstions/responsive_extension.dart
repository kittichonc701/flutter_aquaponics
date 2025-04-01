import 'package:aquaponics/src/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

extension ResponsiveExtensions on BuildContext {
  ResponsiveUtils get responsive => ResponsiveUtils(this);
}
