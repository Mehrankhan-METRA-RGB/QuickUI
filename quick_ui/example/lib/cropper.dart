import 'package:flutter/material.dart';
import 'package:quick_ui/quick_ui.dart';

class Cropper extends StatefulWidget {
  const Cropper({super.key});

  @override
  State<Cropper> createState() => _CropperState();
}

class _CropperState extends State<Cropper> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: QuickCrop(
        initialOffsets: Offset(200, 300),
      ),
    );
  }
}
