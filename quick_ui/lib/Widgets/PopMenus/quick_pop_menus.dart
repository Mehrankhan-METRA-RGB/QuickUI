import 'package:flutter/material.dart';
import 'package:quick_ui/quick_ui.dart';

class QuickPopMenu extends StatefulWidget {
  const QuickPopMenu(
      {super.key,
      this.textStyle,
      this.menuNames,
      this.menuIcons,
      this.boxConstraints,
      this.position,
      this.backgroundColor,
      this.onTab,
      this.shapeBorder,
      this.dividerColor,
      this.dividerWidth,
      this.icon});

  final TextStyle? textStyle;
  final List<String>? menuNames;
  final List<dynamic>? menuIcons;
  final PopupMenuPosition? position;
  final BoxConstraints? boxConstraints;
  final Function(int value, String name)? onTab;
  final Color? backgroundColor;
  final Color? dividerColor;
  final ShapeBorder? shapeBorder;
  final double? dividerWidth;
  final dynamic icon;

  @override
  State<QuickPopMenu> createState() => _QuickPopMenuState();
}

class _QuickPopMenuState extends State<QuickPopMenu> {
  List<PopupMenuItem> menus = [];

  @override
  void initState() {
    for (int i = 0; i < widget.menuNames!.length; i++) {
      menus.add(_menuItem(i));
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PopupMenuThemeData theme = Theme.of(context).popupMenuTheme;

    return PopupMenuButton(
        //padding: EdgeInsets.zero,]
        position: widget.position,
        color: widget.backgroundColor ?? theme.color,
        elevation: 0,
        offset: const Offset(-15, 10),
        constraints: widget.boxConstraints,
        enabled: true,
        shape: widget.shapeBorder ?? theme.shape,
        onSelected: (value) async {
          widget.onTab != null
              ? widget.onTab!(value, widget.menuNames![value])
              : null;
        },
        child: _menuIcon(),
        itemBuilder: (context) {
          return menus;
        });
  }

  _menuItem(int index) {
    return PopupMenuItem(
      padding: EdgeInsets.zero,
      height: 10,
      value: index,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.menuIcons != null
              ? Row(
                  children: [
                    widget.menuIcons![index] is IconData
                        ? Icon(widget.menuIcons![index])
                        : widget.menuIcons![index] is String
                            ? QuickImage(url: widget.menuIcons![index])
                            : widget.menuIcons![index] is Widget
                                ? widget.menuIcons![index]
                                : null,
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.menuNames![index],
                        style: widget.textStyle,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.menuNames![index],
                    style: widget.textStyle,
                  ),
                ),
          if (index != widget.menuNames!.length - 1)
            Divider(thickness: widget.dividerWidth, color: widget.dividerColor),
          // if(index == widget.menuNames!.length - 1 )
          // const  SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget _menuIcon() {
    return widget.icon != null
        ? widget.icon is String
            ? QuickImage(
                url: widget.icon,

              )
            : widget.icon is IconData
                ? Icon(widget.icon)
                : widget.icon is Widget
                    ? widget.icon
                    : const SizedBox()
        :  const SizedBox();
  }
}
