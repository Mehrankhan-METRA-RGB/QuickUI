import 'package:flutter/material.dart';
import 'package:quick_ui/quick_ui.dart';

/// A customizable button widget with support for icons, text, and various styling options.
///
/// Use the [QuickButton] widget to create a button with flexible options for customization,
/// including specifying icons, text, dimensions, colors, and more.
///
/// ## Parameters:
/// - `height`: The height of the button.
/// - `width`: The width of the button.
/// - `borderRadius`: The border radius of the button.
/// - `backgroundColor`: The background color of the button.
/// - `borderColor`: The color of the button's border.
/// - `borderWidth`: The width of the button's border.
/// - `strokeAlign`: The alignment of the button's border stroke.
/// - `borderStyle`: The style of the button's border.
/// - `prefixIcon`: The icon to be displayed before the button's text.
/// - `suffixIcon`: The icon to be displayed after the button's text.
/// - `prefixSize`: The size of the prefix icon.
/// - `suffixSize`: The size of the suffix icon.
/// - `buttonText`: The text to be displayed on the button.
/// - `textStyle`: The style of the button's text.
/// - `child`: An optional child widget to be displayed within the button.
/// - `gapWidth`: The width of the gap between the button elements.
/// - `boxShadow`: The shadow cast by the button.
/// - `prefixColor`: The color of the prefix icon.
/// - `suffixColor`: The color of the suffix icon.
/// - `onTap`: The callback function to be invoked when the button is tapped.
/// - `onDoubleTap`: The callback function to be invoked when the button is double-tapped.
/// - `onLongPress`: The callback function to be invoked when the button is long-pressed.
/// - `onTapDown`: The callback function to be invoked when a tap is detected.
/// - `onTapUp`: The callback function to be invoked when a tap is released.
/// - `onTapCancel`: The callback function to be invoked when a tap is canceled.
/// - `onSecondaryTap`: The callback function to be invoked when a secondary tap is detected.
/// - `onSecondaryTapUp`: The callback function to be invoked when a secondary tap is released.
/// - `onSecondaryTapDown`: The callback function to be invoked when a secondary tap is detected.
/// - `onSecondaryTapCancel`: The callback function to be invoked when a secondary tap is canceled.
/// - `onHighlightChanged`: The callback function to be invoked when the highlight state changes.
/// - `onHover`: The callback function to be invoked when the button is hovered over.
/// - `mouseCursor`: The cursor to be used when the button is hovered over.
/// - `focusColor`: The color of the button when it is focused.
/// - `hoverColor`: The color of the button when it is hovered over.
/// - `highlightColor`: The color of the button when it is highlighted.
/// - `overlayColor`: The overlay color of the button.
/// - `splashColor`: The color of the splash effect when the button is tapped.
/// - `splashFactory`: The factory for creating the splash effect.
///
/// ## Example:
/// ```dart
/// QuickButton(
///   height: 40,
///   width: 120,
///   borderRadius: BorderRadius.circular(8),
///   backgroundColor: Colors.blue,
///   borderColor: Colors.black,
///   borderWidth: 2,
///   prefixIcon: Icons.star,
///   suffixIcon: Icons.arrow_forward,
///   buttonText: 'Press me',
///   textStyle: TextStyle(color: Colors.white),
///   onTap: () {
///     // Handle button tap
///   },
///   onDoubleTap: () {
///     // Handle double tap
///   },
///   onLongPress: () {
///     // Handle long press
///   },
/// )
/// ```

class QuickButton extends StatelessWidget {
  const QuickButton({
    Key? key,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.strokeAlign,
    this.borderStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixSize,
    this.suffixSize,
    this.buttonText,
    this.textStyle,
    this.child,
    this.gapWidth,
    this.boxShadow,
    this.prefixColor,
    this.suffixColor,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapUp,
    this.onSecondaryTapDown,
    this.onSecondaryTapCancel,
    this.onHighlightChanged,
    this.onHover,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.overlayColor,
    this.splashColor,
    this.splashFactory,
  }) : super(key: key);

  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final Size? prefixSize;
  final Size? suffixSize;
  final double? height;
  final double? strokeAlign;
  final double? width;
  final double? gapWidth;
  final double? borderWidth;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? prefixColor;
  final Color? suffixColor;
  final BorderStyle? borderStyle;
  final TextStyle? textStyle;
  final String? buttonText;
  final Widget? child;
  final BoxShadow? boxShadow;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final void Function(TapDownDetails)? onTapDown;
  final void Function(TapUpDetails)? onTapUp;
  final void Function()? onTapCancel;
  final void Function()? onSecondaryTap;
  final void Function(TapUpDetails)? onSecondaryTapUp;
  final void Function(TapDownDetails)? onSecondaryTapDown;
  final void Function()? onSecondaryTapCancel;
  final void Function(bool)? onHighlightChanged;
  final void Function(bool)? onHover;
  final MouseCursor? mouseCursor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTap: onSecondaryTap,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onHighlightChanged: onHighlightChanged,
      onHover: onHover,
      mouseCursor: mouseCursor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      overlayColor: overlayColor,
      splashColor: splashColor,
      splashFactory: splashFactory,
      child: Container(
        height: height,
        width: width,
        decoration: _boxDecoration(),
        child: child ?? _child(),
      ),
    );
  }

  Widget? _child() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) _prefixIcon(),
        if (gapWidth != null) SizedBox(width: gapWidth),
        if (buttonText != null) _textWidget(),
        if (gapWidth != null) SizedBox(width: gapWidth),
        if (suffixIcon != null) _suffixIcon(),
      ],
    );
  }

  Widget _textWidget() {
    return Center(
      child: Text(
        buttonText ?? '',
        style: textStyle,
      ),
    );
  }

  _prefixIcon() {
    return prefixIcon is IconData
        ? Icon(
            prefixIcon,
            color: suffixColor,
            size: prefixSize != null
                ? prefixSize!.height * prefixSize!.width
                : 10,
          )
        : prefixIcon is String
            ? QuickImage(
                height: prefixSize?.height,
                width: prefixSize?.width,
                url: prefixIcon,
                color: prefixColor,
              )
            : prefixIcon is Widget
                ? prefixIcon
                : const SizedBox();
  }

  _suffixIcon() {
    return suffixIcon is IconData
        ? Icon(
            suffixIcon,
            color: suffixColor,
            size: suffixSize != null
                ? suffixSize!.height * suffixSize!.width
                : 10,
          )
        : suffixIcon is String
            ? QuickImage(
                height: suffixSize?.height,
                width: suffixSize?.width,
                color: suffixColor,
                url: suffixIcon,
              )
            : suffixIcon is Widget
                ? suffixIcon
                : const SizedBox();
  }

  Decoration _boxDecoration() {
    return BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: boxShadow != null ? [boxShadow!] : null,
        border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0.0,
            style: borderStyle ?? BorderStyle.solid,
            strokeAlign: strokeAlign ?? 0.0));
  }
}
