import 'package:flutter/material.dart';
import 'package:quick_ui/Widgets/Chips/quick_chip.dart';

class ScrollingTabs extends StatefulWidget {
  ///
  ///assign [list] of Strings  for tabs and List of [widgets] for TabView
  ///
  /// make sure the [list] length and [widgets] length might be same
  ///
  /// [tabStyle] for decorating Tabs
  ///

  const ScrollingTabs({
    super.key,
    required this.buttons,
    required this.widgets,
    this.containerWidth,
    this.buttonWidth,
    // this.tabStyle = const ChipButtonStyle(),
    this.mainAxis = MainAxisAlignment.center,
    this.sizedBoxWidth = 0,
    this.currentTabIndex,
    this.color,
    this.appShadow,
    this.margin,
    this.padding,
    this.borderColor, this.childGap, this.physics, this.scrollController,
  }) : assert(buttons.length == widgets.length,
            'Tabs and Widgets length must be same');
  final List<Widget> buttons;
  final List<Widget> widgets;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  // final ChipButtonStyle tabStyle;
  final double? containerWidth;
  final double? buttonWidth;
  final Color? color;
  final ScrollController? scrollController;
   final Color? borderColor;
  final List<BoxShadow>? appShadow;
  final MainAxisAlignment? mainAxis;
  final double? sizedBoxWidth;
  final int? currentTabIndex;
  final ScrollPhysics? physics;
  final double? childGap;

  ///return current tab Widget
  @override
  State<ScrollingTabs> createState() => _ScrollingTabsState();
}

class _ScrollingTabsState extends State<ScrollingTabs> {
  //int currentTab = 0;
  int? currentTab;
  @override
  void initState() {
    currentTab = widget.currentTabIndex ?? 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: widget.containerWidth ?? double.infinity,
          padding: widget.padding ??
              const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          margin: widget.margin ??
              const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: widget.borderColor ?? Colors.transparent),
              color: widget.color ?? Colors.white,
            boxShadow: widget.appShadow,
          ),
          child: SingleChildScrollView(
            controller: widget.scrollController,
            scrollDirection: Axis.horizontal,
            physics: widget.physics?? const BouncingScrollPhysics(),
            child: SizedBox(
              width: widget.buttonWidth ?? MediaQuery.of(context).size.width,
              child: Row(
                // mainAxisAlignment: widget.mainAxis!,
                children: [
                  for (int i = 0; i < widget.buttons.length; i++)
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            currentTab = i;
                            setState(() {});
                          },
                          child: widget.buttons[i],
                        ),
                         SizedBox(width: widget.childGap?? 40,),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        widget.widgets[currentTab!]
      ],
    );
  }
}
