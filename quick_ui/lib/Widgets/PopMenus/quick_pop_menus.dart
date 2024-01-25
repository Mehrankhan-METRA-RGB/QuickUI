import 'package:flutter/material.dart';
import 'package:quick_ui/quick_ui.dart';

/// QuickPopMenu is a Flutter widget that provides a customizable popup menu. It is designed to be
/// easy to use and highly configurable, allowing developers to create a variety of popup menu
/// styles within their applications.
///
/// To use QuickPopMenu, instantiate it and pass the required parameters, such as [menuNames] (a list
/// of menu item names) and optional parameters for customization, such as [textStyle], [menuIcons],
/// [boxConstraints], [position], [backgroundColor], [onTab], [shapeBorder], [dividerColor],
/// [dividerWidth], [icon], and [iconSize].
///
/// Example usage:
/// ```dart
/// QuickPopMenu(
///   menuNames: ['Option 1', 'Option 2', 'Option 3'],
///   icon: Icons.more_vert,
///   onTab: (value, name) {
///     print('Selected: $name');
///   },
/// )
/// ```


class QuickPopMenu extends StatefulWidget {
  const QuickPopMenu(
      {super.key,
        this.textStyle,
        required this.menuNames,
        this.menuIcons,
        this.boxConstraints,
        this.position,
        this.backgroundColor,
        this.onTab,
        this.shapeBorder,
        this.dividerColor,
        this.dividerWidth,
        this.icon,
        this.iconSize});

  /// The key to uniquely identify this widget.

  /// Style for the text in the menu.
  final TextStyle? textStyle;

  /// List of strings representing the names of the menu items (required).
  final List<String> menuNames;

  /// List of dynamic elements representing icons for each menu item.
  final List<dynamic>? menuIcons;

  /// Position of the popup menu.
  final PopupMenuPosition? position;

  /// Constraints for the menu.
  final BoxConstraints? boxConstraints;

  /// Callback function when a menu item is tapped.
  final Function(int value, String name)? onTab;

  /// Background color of the popup menu.
  final Color? backgroundColor;

  /// Color of the divider between menu items.
  final Color? dividerColor;

  /// Shape of the popup menu.
  final ShapeBorder? shapeBorder;

  /// Width of the divider between menu items.
  final double? dividerWidth;

  /// Icon displayed in the main button triggering the popup menu.
  final dynamic icon;

  /// Size of the icon displayed in the main button.
  final Size? iconSize;

  @override
  State<QuickPopMenu> createState() => _QuickPopMenuState();
}

class _QuickPopMenuState extends State<QuickPopMenu> {
  List<PopupMenuItem> menus = [];

  @override
  void initState() {
    for (int i = 0; i < widget.menuNames.length; i++) {
      menus.add(_menuItem(i));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PopupMenuThemeData theme = Theme.of(context).popupMenuTheme;

    return PopupMenuButton(
      position: widget.position,
      color: widget.backgroundColor ?? theme.color,
      elevation: 0,
      offset: const Offset(-15, 10),
      constraints: widget.boxConstraints,
      enabled: true,
      shape: widget.shapeBorder ?? theme.shape,
      onSelected: (value) async {
        widget.onTab != null
            ? widget.onTab!(value, widget.menuNames[value])
            : null;
      },
      child: _menuIcon(),
      itemBuilder: (context) {
        return menus;
      },
    );
  }

  /// Generates a PopupMenuItem widget for a given index.
  PopupMenuItem _menuItem(int index) {
    return PopupMenuItem(
      padding: EdgeInsets.zero,
      height: 10,
      value: index,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.menuIcons != null
              ? Padding(
            padding: const EdgeInsets.only(left: 7, right: 5),
            child: Row(
              children: [
                widget.menuIcons![index] is IconData
                    ? Icon(widget.menuIcons![index])
                    : widget.menuIcons![index] is String
                    ? QuickImage(url: widget.menuIcons![index])
                    : widget.menuIcons![index] is Widget
                    ? widget.menuIcons![index]
                    : null,
                const SizedBox(width: 5),
                Text(
                  widget.menuNames[index],
                  style: widget.textStyle,
                ),
              ],
            ),
          )
              : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.menuNames[index],
              style: widget.textStyle,
            ),
          ),
          if (index != widget.menuNames.length - 1)
            Divider(
              thickness: widget.dividerWidth,
              color: widget.dividerColor,
            ),
        ],
      ),
    );
  }

  /// Generates the icon widget for the main button.
  Widget _menuIcon() {
    return widget.icon != null
        ? widget.icon is String
        ? QuickImage(
      url: widget.icon,
      height: widget.iconSize?.height,
      width: widget.iconSize?.width,
    )
        : widget.icon is IconData
        ? Icon(widget.icon)
        : widget.icon is Widget
        ? widget.icon
        : const SizedBox()
        : const SizedBox();
  }
}
