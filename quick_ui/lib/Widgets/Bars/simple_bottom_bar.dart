
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    Key? key,
    this.newItems,
    this.centerItemText,
    this.index,
    this.height = 65.0,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    required this.onChange,
  }) : super(key: key);

  ///List of [BarItem]
  final List<Widget>? newItems;
  final String? centerItemText;
  final double? height;
  final int? index;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final void Function(int index) onChange;

  @override
  State<StatefulWidget> createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
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
        children: widget.newItems ??
            [
              BarItem(
                icon: "assets/icons/bottomBarIcons/Home.svg",
                activeIcon: "assets/icons/bottomBarIcons/Home.svg",
                text: 'Home',
                index: 0,
                selectedIndex: currentPageIndex,
                onTap: onSelect,
              ),
              BarItem(
                selectedIndex: currentPageIndex,
                icon: "assets/icons/bottomBarIcons/Swap.svg",
                activeIcon: "assets/icons/bottomBarIcons/Swap.svg",
                text: 'Matched',
                index: 1,
                onTap: onSelect,
              ),
              BarItem(
                selectedIndex: 2,
                icon: 'assets/icons/bottomBarIcons/plus.svg',
                activeIcon: 'assets/icons/bottomBarIcons/plus.svg',
                index: 2,
                size: const Size(40, 40),
                onTap: onSelect,
              ),
              BarItem(
                selectedIndex: currentPageIndex,
                icon: "assets/icons/bottomBarIcons/Chat.svg",
                activeIcon: "assets/icons/bottomBarIcons/Chat.svg",
                text: 'Inbox',
                index: 3,
                onTap: onSelect,
              ),
              BarItem(
                selectedIndex: currentPageIndex,
                icon: "assets/icons/bottomBarIcons/Profile.svg",
                activeIcon: "assets/icons/bottomBarIcons/Profile.svg",
                text: 'Profile',
                index: 4,
                onTap: onSelect,
              ),

            ],
      ),
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

    double _width = size?.width ??
        (selected
            ? _theme.selectedIconTheme?.size
            : _theme.unselectedIconTheme?.size)!
            ;

    double _height = size?.height ??
        (selected
            ? _theme.selectedIconTheme?.size
            : _theme.unselectedIconTheme?.size)!
            ;

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
                    child:
                    (_icon is String && extension?.toLowerCase() == "svg")
                        ? SvgPicture.asset(
                      _icon,
                      width: _width,
                      height: _height,
                      colorFilter: ColorFilter.mode(
                          selected
                              ? _theme.selectedItemColor!
                              : _theme.unselectedItemColor!,
                          BlendMode.srcIn),
                    )
                        : (_icon is String)
                        ? Image.asset(_icon,
                        width: _width,
                        height: _height,
                        color: selected
                            ? _theme.selectedItemColor
                            : _theme.unselectedItemColor)
                        : Icon(
                      _icon,
                      size: _height,
                      weight: 1,
                      color: selected
                          ? _theme.selectedItemColor
                          : _theme.unselectedItemColor,
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
