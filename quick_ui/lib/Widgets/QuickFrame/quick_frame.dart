import 'package:flutter/material.dart';
import 'package:quick_ui/quick_ui.dart';

/// QuickFrame is a customizable class that can be used to create a Frame of any app.
/// It is a combination of [BottomBar] and [PageViewWidget].
/// It is a singleton class, so it can be used to create a single instance of the widget.
/// It is used to create a bottom navigation bar and a page view.
class QuickFrame {
  List<Widget>? pageScreens;
  List<BottomModel>? bottomElements;
  Function(int pageVal)? onPageChanged;
  Function? initCalled;
  Color? backgroundColor;
  Color? bottomBarColor;
  double? elevation;
  double? bottomBarHeight;
  TextStyle? textStyle;
  ScrollPhysics? physics;

  static final QuickFrame _instance = QuickFrame._internal();

  factory QuickFrame({
    Key? key,
    List<Widget>? pageScreens,
    List<BottomModel>? bottomElements,
    Function(int pageVal)? onPageChanged,
    Function? initCalled,
    Color? backgroundColor,
    Color? bottomBarColor,
    double? elevation,
    double? bottomBarHeight,
    ScrollPhysics? physics,
    TextStyle? textStyle = const TextStyle(),
  }) {
    _instance.pageScreens = pageScreens;
    _instance.bottomElements = bottomElements;
    _instance.onPageChanged = onPageChanged;
    _instance.initCalled = initCalled;
    _instance.backgroundColor = backgroundColor;
    _instance.bottomBarColor = bottomBarColor;
    _instance.elevation = elevation;
    _instance.bottomBarHeight = bottomBarHeight;
    _instance.textStyle = textStyle;
    _instance.physics = physics;
    return _instance;
  }

  QuickFrame._internal();

  BottomBar get bottomBar => BottomBar(
        bottomElements: _instance.bottomElements,
        onPageChanged: _instance.onPageChanged,
        bottomBarHeight: _instance.bottomBarHeight,
        bottomBarColor: _instance.bottomBarColor,
        textStyle: _instance.textStyle,
      );

  PageViewWidget get pageWidget => PageViewWidget(
        pageScreens: _instance.pageScreens,
        onPageChanged: _instance.onPageChanged,
        physics: _instance.physics,
      );
}

class BottomBar extends StatelessWidget {
  final List<BottomModel>? bottomElements;
  final Function(int pageVal)? onPageChanged;
  final double? bottomBarHeight;
  final Color? bottomBarColor;
  final TextStyle? textStyle;

  const BottomBar({
    Key? key,
    this.bottomElements,
    this.onPageChanged,
    this.bottomBarHeight = 80.0,
    this.bottomBarColor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return BottomAppBar(
      color: bottomBarColor ?? themeData.bottomAppBarTheme.color,
      elevation: 2.2.rSA,
      shape: const CircularNotchedRectangle(),
      child: ValueListenableBuilder(
        valueListenable: BottomNotifier.bottomNavigationNotifier,
        builder: (context, state, _) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: bottomElements?.map((e) {
                  final int index = bottomElements!.indexOf(e);

                  // print(state == index);
                  return Transform.translate(
                    offset: e.offset ?? const Offset(0, 0),
                    child: InkWell(
                      onTap: () {
                        if (state != index) {
                          BottomNotifier.bottomPageController!
                              .jumpToPage(index);
                          BottomNotifier.bottomNavigationNotifier.value = index;
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          5.y,
                          Expanded(
                            flex: 2,
                            child: Align(
                              child: QuickImage(
                                url: e.path ?? "",
                                height: 30.h,
                                width: 30.w,
                              ),
                            ),
                          ),
                          Expanded(
                            child: QuickText(
                              e.title ?? "",
                              style: textStyle?.copyWith(
                                color: state == index
                                    ? e.selectedColor
                                    : e.unSelectedColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList() ??
                [],
          );
        },
      ),
    );
  }
}

class PageViewWidget extends StatelessWidget {
  final List<Widget>? pageScreens;
  final ScrollPhysics? physics;
  final Function(int pageVal)? onPageChanged;

  const PageViewWidget(
      {Key? key, this.pageScreens, this.onPageChanged, this.physics})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: PageView(
        onPageChanged: (val) {
          BottomNotifier.bottomNavigationNotifier.value = val;
          onPageChanged!(val);
        },
        controller: BottomNotifier.bottomPageController,
        physics: physics ?? const NeverScrollableScrollPhysics(),
        children: pageScreens ?? [],
      ),
    );
  }
}
