
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ProgressBar extends LeafRenderObjectWidget {
  const ProgressBar({
    Key? key,
    required this.barColor,
    required this.thumbColor,
    this.thumbSize = 100.0,
  }) : super(key: key);

  final Color barColor;
  final Color thumbColor;
  final double thumbSize;

  @override
  RenderProgressBar createRenderObject(BuildContext context) {
    return RenderProgressBar(
      barColor: barColor,
      thumbColor: thumbColor,
      thumbSize: thumbSize,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderProgressBar renderObject) {
    renderObject
      ..barColor = barColor
      ..thumbColor = thumbColor
      ..thumbSize = thumbSize;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('barColor', barColor));
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(DoubleProperty('thumbSize', thumbSize));
  }
}

class RenderProgressBar extends RenderBox {
  RenderProgressBar({
    required Color barColor,
    required Color thumbColor,
    required double thumbSize,
  })  : _barColor = barColor,
        _thumbColor = thumbColor,
        _thumbSize = thumbSize {
    _drag = HorizontalDragGestureRecognizer()..onStart = (DragStartDetails details){
      _updateThumbPosition(details.localPosition);
    }..onUpdate = (DragUpdateDetails dragDetails){
      _updateThumbPosition(dragDetails.localPosition);
    };
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }
  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = thumbSize;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  static const _minDesiredWidth = 400.0;
  @override
  double computeMinIntrinsicWidth(double height) => _minDesiredWidth;
  @override
  double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;
  @override
  double computeMinIntrinsicHeight(double width) => thumbSize;
  @override
  double computeMaxIntrinsicHeight(double width) => thumbSize;

   HorizontalDragGestureRecognizer? _drag;


  @override
  bool hitTestSelf(Offset position) => true;


  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag!.addPointer(event);
    }
  }


  void _updateThumbPosition(Offset localPosition) {
    var dx = localPosition.dx;
    _currentThumbValue = dx;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }




   double _currentThumbValue = 5;
  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final point1 = Offset(0, size.width + 30);
    final point2 = Offset(size.width, size.height / 2);

    // paint bar
    final barPaint = Paint()
      ..color = barColor
      ..strokeWidth = 3;
    // final point3 = Offset(0, size.height / 4);
    // final point4 = Offset(size.width, size.height / 4);
    // canvas.drawLine(point1, point2, barPaint);
    // canvas.drawLine(point3, point4, barPaint);
    //
    // paint thumb
    final thumbPaint = Paint()..color = thumbColor;
    final thumbDx = _currentThumbValue;
    final center = Offset(size.width, thumbDx);

    // Draw rectangle with specified corner points
    final rectPaint = Paint()..color = thumbColor..strokeWidth = 3;
    final point5 = Offset(size.width / 2, size.height / 2);
    final point6 = Offset(size.width / 2, size.height);
    final point7 = Offset(size.width, size.height);
    final point8 = Offset(size.width, size.height / 2);
    final rect = Offset.zero & size;
    canvas.drawRect(rect,barPaint);
    canvas.drawLine(center, rect.topRight, thumbPaint);
    canvas.drawLine(rect.topLeft , rect.bottomLeft, thumbPaint);
    canvas.drawLine(rect.bottomLeft , rect.bottomRight, thumbPaint);
    canvas.drawLine(rect.bottomRight , rect.topRight, thumbPaint);
    canvas.drawCircle(center, 4.0, thumbPaint);
    canvas.drawCircle(rect.topLeft ,4.0, thumbPaint);
    canvas.drawCircle(rect.bottomLeft , 4.0, thumbPaint);
    canvas.drawCircle(rect.bottomRight , 4.0, thumbPaint);
    canvas.restore();
  }



  Color get barColor => _barColor;
  Color _barColor;
  set barColor(Color value) {
    if (_barColor == value) {
      return;
    }
    _barColor = value;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;
  Color _thumbColor;
  set thumbColor(Color value) {
    if (_thumbColor == value) {
      return;
    }
    _thumbColor = value;
    markNeedsPaint();
  }

  double get thumbSize => _thumbSize;
  double _thumbSize;
  set thumbSize(double value) {
    if (_thumbSize == value) {
      return;
    }
    _thumbSize = value;
    markNeedsLayout();
  }

}