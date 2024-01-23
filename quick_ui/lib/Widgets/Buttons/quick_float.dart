import 'package:flutter/material.dart';

typedef OnDragUpdate = void Function(DragUpdateDetails);

/// QuickFloat is a customizable floating widget that can be dragged around the screen.
class QuickFloat extends StatefulWidget {
  /// The main content of the floating widget.
  final Widget child;

  /// The initial position of the floating widget.
  final Offset initialOffsets;

  /// Callback function invoked when the drag position is updated.
  final OnDragUpdate? onDragUpdate;

  /// Widget displayed as a copy on the left side while dragging is in progress.
  final Widget? copy;

  /// Widget displayed while dragging is in progress (default is the child itself).
  final Widget? whileDragging;

  /// Widget displayed as the background of the floating widget.
  final Widget? background;

  const QuickFloat({
    Key? key,
    required this.child,
    this.copy,
    this.whileDragging,
    this.initialOffsets = const Offset(100, 100),
    this.onDragUpdate,
    this.background,
  }) : super(key: key);

  @override
  State<QuickFloat> createState() => _QuickFloatState();
}

class _QuickFloatState extends State<QuickFloat> {
  late OverlayEntry overlayEntry;
  late double left;
  late double top;

  @override
  void initState() {
    super.initState();
    left = widget.initialOffsets.dx;
    top = widget.initialOffsets.dy;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: left,
        top: top,
        child: _drag(),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Overlay.of(context).insert(overlayEntry);
    });
  }

  @override
  void dispose() {
    overlayEntry.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.background ?? const SizedBox();

  Widget _drag() => Draggable(
        feedback: widget.whileDragging ?? widget.child,
        onDragUpdate: (details) {
          setState(() {
            left += (details.delta.dx);
            top += (details.delta.dy);
            widget.onDragUpdate?.call(details);
          });
        },
        onDragEnd: (details) {
          setState(() {
            left = left.clamp(0.0, MediaQuery.sizeOf(context).width);
            top = top.clamp(0.0, MediaQuery.sizeOf(context).height);
          });
        },
        childWhenDragging: widget.copy ?? const SizedBox(),
        child: widget.child,
      );
}
