import 'package:flutter/material.dart';
import 'package:quick_ui/Widgets/Chips/quick_chip.dart';

/// Define a StatefulWidget for ScrollingTabs
class ScrollingTabs extends StatefulWidget {
  /// Constructor for ScrollingTabs widget
  const ScrollingTabs({super.key, ///Key for widget identification
    required this.buttons, /// List of tab buttons
    required this.widgets, /// List of corresponding tab views
    this.containerWidth, /// Width of the container
    this.buttonWidth, /// Width of each tab button
    // this.tabStyle = const ChipButtonStyle(), // Styling for tabs (commented out)
    this.mainAxis = MainAxisAlignment.center, /// Alignment of tabs on main axis
    this.sizedBoxWidth = 0, /// Width of SizedBox between tabs
    this.currentTabIndex, /// Index of the initially selected tab
    this.color, /// Background color of the container
    this.appShadow, /// Shadow for the container
    this.margin, /// Margin of the container
    this.padding, /// Padding of the container
    this.borderColor, // Border color of the container
    this.childGap, /// Gap between tab buttons
    this.physics, /// Scroll physics for the SingleChildScrollView
    this.scrollController, /// Scroll controller for SingleChildScrollView
  }) : assert(buttons.length == widgets.length, 'Tabs and Widgets length must be same');

  final List<Widget> buttons; /// List of tab buttons
  final List<Widget> widgets; /// List of tab views
  final EdgeInsets? margin; /// Margin of the container
  final EdgeInsets? padding; /// Padding of the container
  // final ChipButtonStyle tabStyle; /// Styling for tabs (commented out)
  final double? containerWidth; /// Width of the container
  final double? buttonWidth; /// Width of each tab button
  final Color? color; /// Background color of the container
  final ScrollController? scrollController; /// Scroll controller for SingleChildScrollView
  final Color? borderColor; /// Border color of the container
  final List<BoxShadow>? appShadow; /// Shadow for the container
  final MainAxisAlignment? mainAxis; /// Alignment of tabs on main axis
  final double? sizedBoxWidth; /// Width of SizedBox between tabs
  final int? currentTabIndex; /// Index of the initially selected tab
  final ScrollPhysics? physics; /// Scroll physics for the SingleChildScrollView
  final double? childGap; /// Gap between tab buttons

  @override
  State<ScrollingTabs> createState() => _ScrollingTabsState(); // Create state for ScrollingTabs
}

// Define the state for ScrollingTabs
class _ScrollingTabsState extends State<ScrollingTabs> {
  int? currentTab; // Current selected tab index

  @override
  void initState() {
    currentTab = widget.currentTabIndex ?? 0; // Initialize currentTab to currentTabIndex or 0
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: widget.containerWidth ?? double.infinity, // Set container width
          padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 4, horizontal: 5), // Set container padding
          margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 6, horizontal: 5), // Set container margin
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: widget.borderColor ?? Colors.transparent), // Set container border color
            color: widget.color ?? Colors.white, // Set container background color
            boxShadow: widget.appShadow, // Set container shadow
          ),
          child: SingleChildScrollView(
            controller: widget.scrollController, // Set scroll controller
            scrollDirection: Axis.horizontal, // Set scroll direction
            physics: widget.physics ?? const BouncingScrollPhysics(), // Set scroll physics
            child: SizedBox(
              width: widget.buttonWidth ?? MediaQuery.of(context).size.width, // Set width of each tab button
              child: Row(
                children: [
                  for (int i = 0; i < widget.buttons.length; i++)
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            currentTab = i; // Set currentTab to the tapped tab index
                            setState(() {});
                          },
                          child: widget.buttons[i], // Show tab button
                        ),
                        SizedBox(width: widget.childGap ?? 40), // Add SizedBox between tab buttons
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        widget.widgets[currentTab!] // Show the corresponding tab view based on currentTab
      ],
    );
  }
}
