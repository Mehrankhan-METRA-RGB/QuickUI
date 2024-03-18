import 'package:flutter/material.dart';

/// A class that creates and displays a simple toast notification in Flutter.
class QuickToastWidget {
  QuickToastWidget(this.context);

  /// The context in which the toast will be displayed.
  final BuildContext context;

  /// Entry that represents the overlay to be displayed.
  late OverlayEntry overlayEntry;

  /// Shows a toast with specified parameters.
  ///
  /// Parameters:
  ///
  /// - [title]: The main text content to be displayed in the toast.
  ///
  /// - [padding]: The padding around the toast content.
  ///
  /// - [color]: The background color of the toast.
  ///
  /// - [width]: The width of the toast. If not provided, it will be calculated based on the content and padding.
  ///
  /// - [radius]: The border radius of the toast.
  ///
  /// - [fontSize]: The font size of the text content.
  ///
  /// - [elevation]: The elevation of the toast material.
  ///
  /// - [duration]: The duration for which the toast will be displayed.
  ///
  /// - [fontColor]: The font color of the text content.
  ///
  /// - [textAlign]: The alignment of the text content within the toast.
  ///
  /// - [style]: Additional text style applied to the text content.
  ///
  /// - [side]: The border side of the toast.
  ///
  /// - [position]: The vertical position of the toast on the screen from bottom.
  void show({
    required String title,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? width,
    BorderRadiusGeometry? radius,
    double? fontSize,
    double? elevation,
    Duration duration = const Duration(seconds: 3),
    Color? fontColor,
    TextAlign? textAlign,
    TextStyle? style,
    BorderSide side = BorderSide.none,
    double position = 100,
  }) {
    _buildOverlay(
      title,
      padding: padding,
      color: color,
      width: width,
      elevation: elevation ?? 0.0,
      fontSize: fontSize,
      fontColor: fontColor,
      textAlign: textAlign,
      radius: radius,
      position: position,
      style: style,
      side: side,
    );
    _insert(context);
    _remove(duration);
  }

  /// Builds the overlay widget with specified parameters.
  void _buildOverlay(
    String title, {
    EdgeInsetsGeometry? padding,
    Color? color,
    BorderRadiusGeometry? radius,
    double? fontSize,
    double elevation = 0.0,
    Color? fontColor,
    double? width,
    double position = 100,
    TextAlign? textAlign,
    TextStyle? style,
    BorderSide side = BorderSide.none,
  }) {
    // Create a Text widget with the specified parameters.
    Text txt = Text(
      title,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: 1,
      style: _buildTextStyle(
          style: style, fontColor: fontColor, fontSize: fontSize),
    );

    // Get the width of the screen.
    double mediaWidth = MediaQuery.sizeOf(context).width;
    double horizontalPadding = padding?.horizontal ?? mediaWidth * 0.2;

    // Create the overlay entry with the provided parameters.
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100,
        left: width == null ? horizontalPadding : (mediaWidth - width) / 2,
        right: width == null ? horizontalPadding : (mediaWidth - width) / 2,
        child: Material(
          elevation: elevation,
          color: color ?? const Color(0xf2242424),
          shape: RoundedRectangleBorder(
            side: side,
            borderRadius: radius ?? const BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: txt,
          ),
        ),
      ),
    );
  }

  /// Inserts the overlay entry into the specified context.
  void _insert(BuildContext context) {
    Overlay.of(context).insert(overlayEntry);
  }

  /// Removes the overlay entry after a specified duration.
  void _remove(Duration duration) async {
    await Future.delayed(duration, overlayEntry.remove);
  }

  /// Defines the text style with optional customization.
  TextStyle _buildTextStyle({
    double? fontSize,
    Color? fontColor,
    TextStyle? style,
  }) =>
      style?.copyWith(fontSize: fontSize ?? 13, color: fontColor) ??
      TextStyle(
        fontSize: fontSize ?? 13,
        fontWeight: FontWeight.w300,
        color: fontColor ?? const Color(0xf6e2e2e2),
      );
}
