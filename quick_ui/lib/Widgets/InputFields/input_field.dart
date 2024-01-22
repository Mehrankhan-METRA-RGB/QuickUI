import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quick_ui/quick_ui.dart';

class InputFields<T> extends StatefulWidget {
  InputFields(
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
      this.prefixIcon, this.focusedColor, this.unFocusedColor});

  final String? title;
  final TextEditingController? controller;
  final String? hintText;
  final Color? fillColor;
  final Color? focusedColor;
  final Color? unFocusedColor;
  Color? borderColor;
  final T? suffixIcon;
  final double? borderRadius;
  final T? prefixIcon;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final ThemeData? themeData;
  final String? validationText;
  final Widget? label;

  final Function(String value)? onChange;
  final String? Function(String? value)? validator;

 final InputBorder? border;
  final EdgeInsets? contentPadding;
  final InputDecoration? inputDecoration;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final Function(String value)? onFieldSubmit;



  @override
  State<InputFields<T>> createState() => _InputFieldsState<T>();
}

class _InputFieldsState<T> extends State<InputFields<T>> {

  Color? borderColor;


  @override
  void initState() {



    if (widget.focusNode != null) {
      if (mounted) {
        widget.focusNode!.addListener(() {
          log("focus in listener ${widget.focusNode!.hasFocus}");
         if(widget.focusNode!.hasFocus == true){
           log('Focused Call>>');
           widget.borderColor = widget.focusedColor?? widget.borderColor;
         }else{
           log('Unfocused Call>>');
           widget.borderColor = widget.unFocusedColor ?? widget.borderColor;

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
    print("BUILD CALL ${widget.borderColor}");
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
          validator: widget.validator??  (value) {
            if(value!.isNotEmpty){
              return null;
            }else{
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
                  borderSide: const BorderSide(color: Colors.red),
                ),
                enabledBorder: widget.border?.copyWith(
                    borderSide:
                        BorderSide(color: borderColor ?? Colors.transparent)),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: borderColor ?? Colors.transparent)),
                focusedBorder: widget.border,
                hintStyle: widget.textStyle,
                helperStyle: widget.textStyle,
                contentPadding: widget.contentPadding,
                hintText: widget.hintText,
                fillColor: widget.fillColor,
                labelStyle: widget.textStyle,
                // label:widget.label,
                prefixIcon: widget.prefixIcon != null
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
                    : null,
                suffixIcon: widget.suffixIcon != null
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
                    : null,
              ) ??
              InputDecoration(
                labelText: widget.title,
                prefixIcon: widget.prefixIcon != null
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
                    : null,
                suffixIcon: widget.suffixIcon != null
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
                    : null,
                errorBorder: widget.border
                    ?.copyWith(borderSide: const BorderSide(color: Colors.red)),
                enabledBorder: widget.border?.copyWith(
                  borderSide: BorderSide(color: widget.borderColor??Colors.transparent),
                ),
                border: widget.border?.copyWith(

                  borderSide: BorderSide(color: widget.borderColor??Colors.transparent),
                ),
                focusedBorder: widget.border?.copyWith(

                  borderSide: BorderSide(color: widget.borderColor??Colors.transparent),
                ),
                hintText: widget.hintText,
                fillColor: theme.inputDecorationTheme.fillColor,
                errorStyle: theme.inputDecorationTheme.errorStyle,
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
}
