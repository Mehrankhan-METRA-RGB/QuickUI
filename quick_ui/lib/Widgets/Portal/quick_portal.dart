import 'package:flutter/material.dart';

/// QuickPortal is a widget that creates a portal to display an overlay on top of another widget.
/// The overlay can be customized with various properties such as [overlayChild], [offset],
/// [alignment], [overlaySize], [childDecoration], [childAnimationDuration], and [animationType].
/// The overlay can be displayed using an [OverlayPortalController] to control its visibility.
/// The main content of the portal is displayed as a child widget, while the overlay content is
/// displayed as an overlay child widget.
/// will be Used instead of DropDowns, Popups, etc.
/// [Alignment] is used to position the overlay child relative to the main child.Keep in mind it is inverse

class QuickPortal extends StatefulWidget {
  final Widget child;
  final Widget overlayChild;
  final OverlayPortalController controller;
  final Offset offset;
  final Alignment alignment;
  //final Size? overlaySize;
  final double? overlayWidth;
  final double? overlayHeight;
  final BoxDecoration? childDecoration;
  final Duration childAnimationDuration;
  final AnimationType animationType;

  QuickPortal({
    super.key,
    this.overlayWidth,
    this.overlayHeight,
    this.childDecoration,
    required this.child,
    this.childAnimationDuration = const Duration(milliseconds: 300),
    required this.overlayChild,
    required this.controller,
    this.offset = const Offset(0, 50),
    this.alignment = Alignment.topLeft,
    this.animationType = AnimationType.scale,
  });

  @override
  State<QuickPortal> createState() => _QuickPortalState();
}

class _QuickPortalState extends State<QuickPortal> {
  final LayerLink link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: widget.controller,
      child: CompositedTransformTarget(
        link: link,
        child: widget.child,
      ),
      overlayChildBuilder: (context) {
        return TapRegion(
          onTapOutside: (ss) {
            widget.controller.isShowing ? widget.controller.hide() : null;
          },
          onTapInside: (c) {},
          child: CompositedTransformFollower(
            offset: widget.offset,
            link: link,
            followerAnchor: widget.alignment,
            child: Align(
              alignment: widget.alignment,
              child: AnimatedOverlayChild(
                duration: widget.childAnimationDuration,
                decoration: widget.childDecoration,
                // size: overlaySize,
                childHeight: widget.overlayHeight,
                childWidth: widget.overlayWidth,
                animationType: widget.animationType,
                child: widget.overlayChild,
              ),
            ),
          ),
        );
      },
    );
  }
}

enum AnimationType { scale, fade, rotate, none }

class AnimatedOverlayChild extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final BoxDecoration? decoration;
  final double? childWidth;
  final double? childHeight;
  final AnimationType animationType;

  const AnimatedOverlayChild({
    super.key,
    required this.child,
    this.childWidth,
    this.childHeight,
    required this.duration,
    this.decoration,
    required this.animationType,
  });

  @override
  _AnimatedOverlayChildState createState() => _AnimatedOverlayChildState();
}

class _AnimatedOverlayChildState extends State<AnimatedOverlayChild>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    switch (widget.animationType) {
      case AnimationType.scale:
        _animation =
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
        break;
      case AnimationType.fade:
        _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
        break;
      case AnimationType.rotate:
        _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
        break;
      case AnimationType.none:
        break;
      // TODO: Handle this case.
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedChild;

    switch (widget.animationType) {
      case AnimationType.scale:
        animatedChild = ScaleTransition(scale: _animation, child: widget.child);
        break;
      case AnimationType.fade:
        animatedChild =
            FadeTransition(opacity: _animation, child: widget.child);
        break;
      case AnimationType.rotate:
        animatedChild =
            RotationTransition(turns: _animation, child: widget.child);
        break;
      case AnimationType.none:
        animatedChild = widget.child;
      // TODO: Handle this case.
    }

    return Container(
      decoration: widget.decoration,
      width: widget.childWidth,
      height: widget.childHeight,
      child: animatedChild,
    );
  }
}
