import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quick_ui/quick_ui.dart';

typedef VoidInputChange = void Function(String value);
typedef InputBorderColor = Color Function(Color? value);

class InputFields<T> extends StatefulWidget {
  const InputFields(
      {super.key,
      this.title,
      this.controller,
      this.validator,
      this.label,
      this.hintText,
      this.fillColor,
      this.focusNode,
      this.border,
      this.borderColor,
      this.onChange,
      this.borderRadius,
      this.textStyle,
      this.themeData,
      this.validationText,
      this.contentPadding,
      this.inputDecoration,
      this.onFieldSubmit,
      this.onEditingComplete,
      this.onTap,
      this.suffixIcon,
      this.prefixIcon,
      this.focusedColor,
      this.unFocusedColor,
      this.borderWidth = 1,
      this.borderStyle = BorderStyle.solid,
      this.borderStrokeAlign = BorderSide.strokeAlignInside,
      this.errorColor});

  final String? title;
  final TextEditingController? controller;
  final String? hintText;
  final Color? fillColor;
  final Color? errorColor;
  final Color? focusedColor;
  final Color? unFocusedColor;
  final InputBorderColor? borderColor;
  final T? suffixIcon;
  final double? borderRadius;
  final T? prefixIcon;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final ThemeData? themeData;
  final String? validationText;
  final Widget? label;
  final double borderWidth;
  final BorderStyle borderStyle;
  final double borderStrokeAlign;
  final VoidInputChange? onChange;
  final String? Function(String? value)? validator;
  final InputBorder? border;
  final EdgeInsets? contentPadding;
  final InputDecoration? inputDecoration;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final VoidInputChange? onFieldSubmit;

  @override
  State<InputFields<T>> createState() => _InputFieldsState<T>();
}

class _InputFieldsState<T> extends State<InputFields<T>> {
  Color? borderColor;

  @override
  void initState() {
    ///TODO:ORIGINAL CODE
    // if (widget.focusNode != null) {
    //   if (mounted) {
    //     widget.focusNode!.addListener(() {
    //       log("focus in listener ${widget.focusNode!.hasFocus}");
    //       if (widget.focusNode!.hasFocus == true) {
    //         log('Focused Call>>');
    //         if (widget.borderColor != null) {
    //           borderColor = widget.borderColor!(widget.focusedColor);
    //         }
    //         // widget.borderColor = ;
    //       } else {
    //         log('Unfocused Call>>');
    //         if (widget.borderColor != null) {
    //           borderColor = widget.borderColor!(widget.unFocusedColor);
    //         }
    //       }
    //       setState(() {});
    //     });
    //   }

    ///TODO:OPTIMIZE CODE FOR TESTING
    if (widget.focusNode != null) {
      if (mounted) {
        widget.focusNode!.addListener(() {
          log("focus in listener ${widget.focusNode!.hasFocus}");
          if (widget.focusNode!.hasFocus == true) {
            log('Focused Call>>');
            if (widget.borderColor != null) {
              borderColor = widget.borderColor!(widget.focusedColor);
            }
            // widget.borderColor = ;
          } else {
            log('Unfocused Call>>');
            if (widget.borderColor != null) {
              borderColor = widget.borderColor!(widget.unFocusedColor);
            }
          }
          setState(() {});
        });
      }
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("BUILD CALL $borderColor");
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text(
                widget.title!,
                style: widget.textStyle ?? theme.textTheme.bodyLarge,
              )),
        TextFormField(
          validator: widget.validator ??
              (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return widget.validationText;
                }
              },
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmit,
          onTap: widget.onTap,
          focusNode: widget.focusNode,
          controller: widget.controller,
          onChanged: widget.onChange,
          decoration: widget.inputDecoration?.copyWith(
                labelText: widget.title,
                errorBorder: widget.border?.copyWith(
                  borderSide: _borderSide(
                      color: widget.errorColor ??
                          theme.inputDecorationTheme.errorBorder?.borderSide
                              .color),
                ),
                enabledBorder: widget.border?.copyWith(
                  borderSide: _borderSide(color: borderColor),
                ),
                border: OutlineInputBorder(
                    borderSide: _borderSide(color: borderColor)),
                focusedBorder: widget.border,
                hintStyle: widget.textStyle,
                helperStyle: widget.textStyle,
                contentPadding: widget.contentPadding,
                hintText: widget.hintText,
                fillColor: widget.fillColor,
                labelStyle: widget.textStyle,
                // label:widget.label,
                prefixIcon: _prefixIcon(context),
                suffixIcon: _suffixIcon(context),
              ) ??
              InputDecoration(
                labelText: widget.title,
                prefixIcon: _prefixIcon(context),
                suffixIcon: _suffixIcon(context),
                errorBorder: widget.border?.copyWith(
                  borderSide: _borderSide(
                      color: widget.errorColor ??
                          theme.inputDecorationTheme.errorBorder?.borderSide
                              .color),
                ),
                enabledBorder: widget.border?.copyWith(
                  borderSide: _borderSide(color: borderColor),
                ),
                border: widget.border?.copyWith(
                  borderSide: _borderSide(color: borderColor),
                ),
                focusedBorder: widget.border?.copyWith(
                  borderSide: _borderSide(color: borderColor),
                ),
                hintText: widget.hintText,
                fillColor: theme.inputDecorationTheme.fillColor,
                errorStyle: theme.inputDecorationTheme.errorStyle
                    ?.copyWith(color: widget.errorColor),
                focusColor: theme.inputDecorationTheme.focusColor,
                contentPadding: theme.inputDecorationTheme.contentPadding,
                labelStyle:
                    widget.textStyle ?? theme.inputDecorationTheme.labelStyle,
                helperStyle:
                    widget.textStyle ?? theme.inputDecorationTheme.helperStyle,
                hintStyle:
                    widget.textStyle ?? theme.inputDecorationTheme.hintStyle,
              ),
        ),
      ],
    );
  }

  Widget? _prefixIcon(BuildContext context) {
    return widget.prefixIcon != null
        ? widget.prefixIcon is IconData
            ? Icon(widget.prefixIcon as IconData)
            : widget.prefixIcon is String
                ? QuickImage(
                    height: 10,
                    width: 10,
                    color: Colors.yellow,
                    url: widget.prefixIcon,
                  )
                : widget.prefixIcon is Widget
                    ? widget.prefixIcon as Widget
                    : null
        : null;
  }

  Widget? _suffixIcon(BuildContext context) {
    return widget.suffixIcon != null
        ? widget.suffixIcon is IconData
            ? Icon(widget.suffixIcon as IconData)
            : widget.suffixIcon is String
                ? QuickImage(
                    height: 10,
                    width: 10,
                    color: Colors.yellow,
                    url: widget.suffixIcon,
                  )
                : widget.suffixIcon is Widget
                    ? widget.suffixIcon as Widget
                    : null
        : null;
  }

  BorderSide _borderSide({
    Color? color = const Color(0x00ffffff),
  }) =>
      BorderSide(
          color: color ?? const Color(0xFF000000),
          width: widget.borderWidth,
          style: widget.borderStyle,
          strokeAlign: widget.borderStrokeAlign);
}
