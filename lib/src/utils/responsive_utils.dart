import 'package:flutter/material.dart';

class ResponsiveUtils {
  final BuildContext context;

  ResponsiveUtils(this.context);

  bool get isMobile => MediaQuery.of(context).size.width < 600;
  bool get isTablet =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;
  bool get isDesktop => MediaQuery.of(context).size.width >= 1200;
  bool get isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  double widthPercent(double percent) =>
      MediaQuery.of(context).size.width * (percent / 100);
  double heightPercent(double percent) =>
      MediaQuery.of(context).size.height * (percent / 100);

  double responsiveFontSize(
      {double mobile = 14, double tablet = 16, double desktop = 18}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }

  EdgeInsets responsivePadding({
    double mobile = 8.0,
    double tablet = 16.0,
    double desktop = 24.0,
  }) {
    final value = isMobile ? mobile : (isTablet ? tablet : desktop);
    return EdgeInsets.all(value);
  }

  EdgeInsets responsiveMargin({
    double mobile = 8.0,
    double tablet = 16.0,
    double desktop = 24.0,
  }) {
    final value = isMobile ? mobile : (isTablet ? tablet : desktop);
    return EdgeInsets.all(value);
  }

  double responsiveIconSize({
    double mobile = 24.0,
    double tablet = 32.0,
    double desktop = 40.0,
  }) {
    return isMobile ? mobile : (isTablet ? tablet : desktop);
  }

  SizedBox responsiveVerticalSpace({
    double mobile = 10.0,
    double tablet = 20.0,
    double desktop = 30.0,
  }) {
    return SizedBox(height: isMobile ? mobile : (isTablet ? tablet : desktop));
  }

  SizedBox responsiveHorizontalSpace({
    double mobile = 10.0,
    double tablet = 20.0,
    double desktop = 30.0,
  }) {
    return SizedBox(width: isMobile ? mobile : (isTablet ? tablet : desktop));
  }
}
