import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_ui/quick_ui.dart';

class SimpleBottomBar extends StatefulWidget {
  const SimpleBottomBar({
    Key? key,
    required this.items,
    this.centerItemText,
    this.index,
    this.height = 65.0,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    required this.onChange,
  }) : super(key: key);

  ///Suggested to use List of [BarItem]
  final List<Widget> items;
  final String? centerItemText;
  final double? height;
  final int? index;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final void Function(int index) onChange;

  @override
  State<StatefulWidget> createState() => SimpleBottomBarState();
}

class SimpleBottomBarState extends State<SimpleBottomBar> {
  @override
  void initState() {
    super.initState();
  }

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.index != null) currentPageIndex = widget.index!;
    return BottomAppBar(
      height: widget.height,
      padding: const EdgeInsets.all(2),

      shadowColor: Theme.of(context).bottomAppBarTheme.shadowColor,
      color:
          widget.backgroundColor ?? Theme.of(context).bottomAppBarTheme.color,
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.items),
    );
  }

  void onSelect(index) {
    setState(() {
      currentPageIndex = index;
    });
    widget.onChange(index);
  }
}

class BarItem<T> extends StatelessWidget {
  const BarItem(
      {required this.icon,
      required this.activeIcon,
      required this.index,
      required this.selectedIndex,
      required this.onTap,
      this.text,
      this.size,
      this.counts,
      this.theme,
      super.key});

  final Size? size;
  final T? icon;
  final T? activeIcon;
  final String? text;
  final void Function(int index) onTap;
  final int index;
  final int selectedIndex;
  final ValueNotifier<int>? counts;
  final BottomNavigationBarThemeData? theme;

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarThemeData? _theme =
        theme ?? Theme.of(context).bottomNavigationBarTheme;
    late ValueNotifier<int> count = counts ?? ValueNotifier(0);

    bool selected = index == selectedIndex;

    double? _width = size?.width ??
        (selected
            ? _theme.selectedIconTheme?.size
            : _theme.unselectedIconTheme?.size);

    double? _height = size?.height ??
        (selected
            ? _theme.selectedIconTheme?.size
            : _theme.unselectedIconTheme?.size);

    dynamic _icon = selected ? activeIcon : icon;

    late String? extension;

    if (icon is String) {
      extension = (selected ? activeIcon : icon).toString().split('.').last;
    }
    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ValueListenableBuilder(
          valueListenable: count,
          builder: (context, counts, child) => Badge(
            isLabelVisible: counts > 0,
            label: Text(
              "${counts < 100 ? counts : "99+"}",
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: _width,
                    height: _height,
                    child: QuickImage(
                            url: _icon,
                            height: _height,
                            width: _width,
                          )),
                if (text != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      text!,
                      overflow: TextOverflow.fade,
                      style: selected
                          ? _theme.selectedLabelStyle
                          : _theme.unselectedLabelStyle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
