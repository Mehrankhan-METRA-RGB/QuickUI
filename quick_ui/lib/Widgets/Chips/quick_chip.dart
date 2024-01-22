import 'package:flutter/material.dart';
import 'package:quick_ui/Widgets/Images/quick_image.dart';

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

  final void Function()? onTap;
  final String? label;
  final Color? borderColor;
  final T? avatar;
  final Color? shadowColor;
  final OutlinedBorder? shape;
  final BorderSide? borderSide;
  final TextStyle? labelStyle;
  final EdgeInsets? padding;
  final T? deleteIcon;
  final void Function()? onDeleted;
  final Color? backgroundColor;
  final double? elevation;

  @override
  State<QuickChip> createState() => _QuickChipState();
}

class _QuickChipState extends State<QuickChip> {
  @override
  Widget build(BuildContext context) {
    return widget.onTap != null
        ? InkWell(onTap: widget.onTap, child: _chipWidget())
        : _chipWidget();
  }

  _chipWidget() {
    return Chip(
      avatar: widget.avatar != null
          ? widget.avatar is IconData
              ? Icon(widget.avatar as IconData)
              : widget.avatar is String
                  ? QuickImage(
                      url: widget.avatar,
                    )
                  : widget.avatar
          : null,
      shadowColor:
          widget.shadowColor ?? Theme.of(context).chipTheme.shadowColor,
      onDeleted: widget.onDeleted,
      labelStyle: widget.labelStyle ?? Theme.of(context).chipTheme.labelStyle,
      padding: widget.padding ?? Theme.of(context).chipTheme.padding,
      deleteIcon: widget.deleteIcon != null
          ? widget.deleteIcon is IconData
              ? Icon(widget.deleteIcon as IconData)
              : widget.deleteIcon is String
                  ? QuickImage(
                      url: widget.deleteIcon,
                    )
                  : widget.deleteIcon
          : null,
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
