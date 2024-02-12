import 'package:flutter/material.dart';

class QuickDropDown extends StatelessWidget {
  final Widget? prefixIcon;
  final String hintText;
  final dynamic value;
  final double vMargin;
  final double hMargin;
  final double? dropDownHeight;
  final String validationText;
  final ValueChanged onChanged;
  final List<DropdownMenuItem<Object>> itemsMap;
  final bool isBorderRequired;
  final bool isShadowRequired;
  final BoxConstraints? constraints;
  final EdgeInsets? contentPadding;
  final TextStyle? hintStyle;
  final InputBorder? inputBorder;
  final Widget? arrowIcon;
  final Color? fillColor;
  final FocusNode? focusNode;


  const QuickDropDown({
    super.key,
    this.hMargin = 8,
    this.vMargin = 0,
    this.dropDownHeight,
    this.prefixIcon,
    required this.hintText,
    required this.value,
    required this.validationText,
    required this.onChanged,
    required this.itemsMap,
    this.isBorderRequired = true,
    this.isShadowRequired = false,
    this.constraints,
    this.contentPadding,
    this.hintStyle,
    this.inputBorder,
    this.arrowIcon,
    this.fillColor, this.focusNode,
  });

  final double borderRadius = 25;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField(
        borderRadius: BorderRadius.circular(15),
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        menuMaxHeight: dropDownHeight,

        validator: (value) {
          if (value == null) {
            return validationText;
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: true,
          prefixIconConstraints: constraints ??
              const BoxConstraints(
                maxHeight: 50,
                maxWidth: 50,
                minHeight: 20,
                minWidth: 23,
              ),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: prefixIcon,
                )
              : null,
          errorMaxLines: 1,
          contentPadding: contentPadding ??
              EdgeInsets.only(
                top: 10,
                bottom: 15,
                left: prefixIcon != null ? 8 : 6,
                right: prefixIcon != null ? 10 : 12,
              ),

          // EdgeInsets.symmetric(
          //   vertical: 13,
          //   horizontal: prefixIcon != null ? 10 : 6,
          // ).r,
          hintStyle: hintStyle,
          errorBorder: isBorderRequired ? inputBorder?.copyWith(
            borderSide: const BorderSide(color: Colors.red),
          ) : outlineInputBorder(),
          enabledBorder: isBorderRequired ? inputBorder : outlineInputBorder(),
          focusedBorder: isBorderRequired ? inputBorder : outlineInputBorder(),
          focusedErrorBorder:
              isBorderRequired ? inputBorder?.copyWith(
                borderSide: const BorderSide(color: Colors.red),
              ) : outlineInputBorder(),
        ),
        hint: Text(
          hintText,
          style: hintStyle,
        ),
        focusNode: focusNode,
        dropdownColor: Colors.white,
        icon: arrowIcon,
        isExpanded: true,
        style: hintStyle,
        value: value,
        onChanged: onChanged,
        items: itemsMap,
      ),
    );
  }

  outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }
}
