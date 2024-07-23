import 'package:flutter/material.dart';

// This functions are responsible to make UI responsive across all the mobile devices.

MediaQueryData mediaQueryData = MediaQueryManager().mediaQueryData;

///This extension is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
extension ResponsiveExtension on num {
  ///This method is used to get device viewport width.
  static num? figmaDesignWidth = MediaQueryManager.instance.designWidth;
  static num? figmaDesignHeight = MediaQueryManager.instance.designHeight;
  static num? figmaStatusBarHeight = MediaQueryManager.instance.designStatusBar;
  double get _width {
    return mediaQueryData.size.width;
  }

  ///This method is used to get device viewport height.
  double get _height {
    double statusBar = mediaQueryData.viewPadding.top;
    double bottomBar = mediaQueryData.padding.bottom;
    double screenHeight = mediaQueryData.size.height - statusBar - bottomBar;
    return screenHeight;
  }

  ///statusBar
  get stB => mediaQueryData.viewPadding.top;

  ///bottom bar
  double get btB => mediaQueryData.viewPadding.bottom;
  double get sh => this * _height;
  double get sw => this * _width;

  ///symmetric  horizontal
  ///This method is used to set padding/margin (for the left and Right side) & width of the screen or widget according to the Viewport width.
  double get w => ((this * _width) / figmaDesignWidth!);

  ///symmetric vertical
  ///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
  double get h =>
      (this * _height) / (figmaDesignHeight! - figmaStatusBarHeight!);

  ///This method is used to set smallest px in image height and width [[rsa]] responsive size  adjust
  double get rSA {
    var height = h;
    var width = w;
    return height < width ? height.toDoubleValue() : width.toDoubleValue();
  }

  ///This method is used to set text font size according to Viewport
  double get fS => rSA;
  double get r {
    return rSA / 2;
  }
}

extension FormatExtension on double {
  /// Return a [double] value with formatted according to provided fractionDigits
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }
}

class MediaQueryManager with DesignSizeInit {
  MediaQueryManager._();

  static final MediaQueryManager instance = MediaQueryManager._();

  MediaQueryData? _mediaQueryData;

  factory MediaQueryManager() {
    return instance;
  }

  ///Initialize Media Query Entry Point
  void initialize(BuildContext context,
      {num? designHeight, num? designWidth, num? statusBarHeight}) {
    instance.designHeight = designHeight ?? 890;
    instance.designWidth = designWidth ?? 396;
    instance.designStatusBar = statusBarHeight ?? 0;
    _mediaQueryData ??= MediaQuery.of(context);
  }

  MediaQueryData get mediaQueryData {
    if (_mediaQueryData == null) {
      throw Exception('MediaQueryManager not initialized');
    }
    return _mediaQueryData!;
  }
}

mixin DesignSizeInit {
  /// These are the Viewport values of your Figma Design.
/// These are used in the code as a reference to create your UI Responsively.
  num? get designWidth => _designWidth;
  num? get designHeight => _designHeight;
  num? get designStatusBar => _designStatusBar;

  static num? _designWidth;
  static num? _designHeight;
  static num? _designStatusBar;
  set designWidth(num? width) => _designWidth = width;
  set designHeight(num? height) => _designHeight = height;
  set designStatusBar(num? statusBarHeight) =>
      _designStatusBar = statusBarHeight;
}
