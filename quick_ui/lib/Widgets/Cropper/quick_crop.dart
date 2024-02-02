import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:quick_ui/Widgets/Buttons/quick_float.dart';

/// QuickFloat is a customizable floating widget that can be dragged around the screen.
class QuickCrop extends StatefulWidget {
  /// The main content of the floating widget.
  final Widget? child;

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

  const QuickCrop({
    Key? key,
    this.child,
    this.copy,
    this.whileDragging,
    required this.initialOffsets,
    this.onDragUpdate,
    this.background,
  }) : super(key: key);

  @override
  State<QuickCrop> createState() => _QuickCropState();
}

class _QuickCropState extends State<QuickCrop> {
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
  Widget build(BuildContext context) =>
      widget.background ??
      const FlutterLogo(
        size: 300,
      );

  Widget _drag() => Draggable(
        feedback: widget.whileDragging ?? _c(),
        onDragUpdate: (details) {
          setState(() {
            left += details.delta.dx;
            top += details.delta.dy;

            widget.onDragUpdate?.call(details);
          });
        },
        onDragEnd: (details) {
          setState(() {
            // Clamp the position to ensure it stays within the scene area.
            left = left.clamp(0.0, MediaQuery.of(context).size.width - 15);
            top = top.clamp(0.0, MediaQuery.of(context).size.height - 15);
          });
        },
        childWhenDragging: widget.copy ?? const SizedBox(),
        child: _c(),
      );

  Widget _c() {
    return GestureDetector(

      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.black45)),
      ),
    );
  }
}

class WidgetImageCapture {
  static Future<void> captureAndSaveAsImage(BuildContext context, Widget widget,
      {String? fileName}) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;

    final RenderRepaintBoundary repaintBoundary =
        RenderRepaintBoundary(child: renderBox);

    final ui.Image image = await repaintBoundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List? uint8List = byteData?.buffer.asUint8List();
    File('${fileName ?? "QuickCrop-${DateTime.now().millisecondsSinceEpoch}"}.png')
        .writeAsBytes(uint8List!);
  }
}

class PngHome extends StatefulWidget {
  const PngHome({super.key});

  @override
  State<PngHome> createState() => _PngHomeState();
}

class _PngHomeState extends State<PngHome> {
  GlobalKey globalKey = GlobalKey();

  Future _capturePng() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: Center(
        child: TextButton(
          onPressed: _capturePng,
          child: const Text('Hello World', textDirection: TextDirection.ltr),
        ),
      ),
    );
  }
}
