import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  static double _screenWidth = 0;
  static double _screenHeight = 0;

  static void init(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
  }

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
  
  // 字体大小
  static double get textSmall => _screenWidth * 0.035; // 小字体，例如 12-14px
  static double get textRegular => _screenWidth * 0.045; // 常规字体，例如 16-18px
  static double get textLarge => _screenWidth * 0.06; // 大字体，例如 20-24px

  // 圆角
  static double get radiusSmall => _screenWidth * 0.01; // 小圆角，例如 4-6px
  static double get radiusRegular => _screenWidth * 0.02; // 常规圆角，例如 8-12px
  static double get radiusLarge => _screenWidth * 0.03; // 大圆角，例如 12-16px

  // 间距
  static double get paddingSmall => _screenWidth * 0.02; // 小间距，例如 8-10px
  static double get paddingRegular => _screenWidth * 0.04; // 常规间距，例如 16-20px
  static double get paddingLarge => _screenWidth * 0.06; // 大间距，例如 24-30px

  // 图标大小
  static double get iconSmall => _screenWidth * 0.06; // 小图标，例如 20-24px
  static double get iconRegular => _screenWidth * 0.08; // 常规图标，例如 28-32px
  static double get iconLarge => _screenWidth * 0.1; // 大图标，例如 36-40px

  // 限制最小/最大值，防止极端屏幕尺寸
  static double clamp(double value, double min, double max) {
    return value.clamp(min, max);
  }
}