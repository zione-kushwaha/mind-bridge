import 'package:flutter/material.dart';

const double FIGMA_DESIGN_WIDTH = 360;
const double FIGMA_DESIGN_HEIGHT = 800;
const double FIGMA_DESIGN_STATUS_BAR = 0;

typedef ResponsiveBuild = Widget Function(
  BuildContext context,
  DeviceType deviceType,
);

class Sizer extends StatefulWidget {
  const Sizer({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final ResponsiveBuild builder;

    @override
  _SizerState createState() => _SizerState();
}

class _SizerState extends State<Sizer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      SizeUtils.setScreenSize(constraints);
      return widget.builder(context, SizeUtils.deviceType);
    });
  }
}

class SizeUtils {
  static late double width;
  static late double height;
  static late DeviceType deviceType;

  static void setScreenSize(BoxConstraints constraints) {
    width = constraints.maxWidth.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
    height = constraints.maxHeight.isNonZero();
    deviceType = DeviceType.mobile;
  }
}

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get _height => SizeUtils.height;

  double get h => ((this * _width) / FIGMA_DESIGN_WIDTH);
  double get v => (this * _height) / (FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR);

  double get adaptSize => (v < h) ? v.toDoubleValue() : h.toDoubleValue();
  double get fSize => adaptSize;
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile }
