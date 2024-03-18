import 'package:flutter/material.dart';
import 'package:quick_ui/Widgets/Images/quick_image.dart';

/// QuickChip is a customizable chip widget that can be used to display
/// information with an optional avatar, label, and delete icon. It extends
/// [StatefulWidget], allowing dynamic updates to its properties. The chip's
/// appearance can be configured using various properties such as [backgroundColor],
/// [borderColor], [elevation], and more.
///
/// ## Usage
/// ```dart
/// QuickChip(
///   label: 'Example Chip',
///   onTap: () {
///     // Handle chip tap event
///   },
///   onDeleted: () {
///     // Handle chip deletion event
///   },
///   avatar: Icons.person,
///   deleteIcon: Icons.close,
///   borderColor: Colors.blue,
///   elevation: 2.0,
///   backgroundColor: Colors.white,
///   labelStyle: TextStyle(color: Colors.black),
/// )
/// ```
class QuickChip<T> extends StatefulWidget {
  const QuickChip({
    super.key,
    this.onTap,
    this.label,
    this.borderColor,
    this.shape,
    this.borderSide,
    this.labelStyle,
    this.padding,
    this.deleteIcon,
    this.onDeleted,
    this.backgroundColor,
    this.shadowColor,
    this.elevation,
    this.avatar,
  });

  /// A callback function triggered when the chip is tapped.
  final void Function()? onTap;

  /// The text label displayed on the chip.
  final String? label;

  /// The color of the chip's border.
  final Color? borderColor;

  /// An optional avatar displayed on the left side of the chip.
  final T? avatar;

  /// The color of the chip's shadow.
  final Color? shadowColor;

  /// The shape of the chip.
  final OutlinedBorder? shape;

  /// The side of the chip's border.
  final BorderSide? borderSide;

  /// The style of the label text.
  final TextStyle? labelStyle;

  /// The padding around the chip's content.
  final EdgeInsets? padding;

  /// An optional delete icon displayed on the right side of the chip.
  final T? deleteIcon;

  /// A callback function triggered when the delete icon is tapped.
  final void Function()? onDeleted;

  /// The background color of the chip.
  final Color? backgroundColor;

  /// The elevation of the chip.
  final double? elevation;

  @override
  State<QuickChip> createState() => _QuickChipState();
}

class _QuickChipState extends State<QuickChip> {
  @override
  Widget build(BuildContext context) {
    print("here is icon ${widget.deleteIcon}");

    return widget.onTap != null
        ? InkWell(onTap: widget.onTap, child: _chipWidget())
        : _chipWidget();
  }

  _chipWidget() {
    return Chip(
      avatar: widget.avatar != null
          ? widget.avatar is Widget
              ? widget.avatar
              : QuickImage(
                  url: widget.avatar,
                )
          : null,
      shadowColor:
          widget.shadowColor ?? Theme.of(context).chipTheme.shadowColor,
      onDeleted: widget.onDeleted,
      labelStyle: widget.labelStyle ?? Theme.of(context).chipTheme.labelStyle,
      padding: widget.padding ?? Theme.of(context).chipTheme.padding,
      deleteIcon: widget.deleteIcon is Widget
          ? widget.deleteIcon
          : QuickImage(
              url: widget.deleteIcon,
            ),
      label: Text(
        widget.label ?? "",
        style: widget.labelStyle ?? Theme.of(context).chipTheme.labelStyle,
      ),
      elevation: widget.elevation ?? Theme.of(context).chipTheme.elevation,
      backgroundColor:
          widget.backgroundColor ?? Theme.of(context).chipTheme.backgroundColor,
      shape: widget.shape?.copyWith(
          side: BorderSide(color: widget.borderColor ?? Colors.transparent)),
    );
  }

  TextStyle? style(BuildContext context, Color color) => Theme.of(context)
      .textTheme
      .displaySmall
      ?.copyWith(fontWeight: FontWeight.normal, color: color);
}
