import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MeasureWidget extends StatefulWidget {
  const MeasureWidget({super.key,required this.child, required this.onMeasured});
  final Widget child;
  final Function(Size size) onMeasured;

  @override
  State<MeasureWidget> createState() => _MeasureWidgetState();
}

class _MeasureWidgetState extends State<MeasureWidget> {
   final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {

        WidgetsBinding.instance!.addPostFrameCallback((_) {
      final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
      final size = renderBox.size;
      widget.onMeasured(size);
    });

      return Container(
      key: _key,
      child: widget.child,
    );
  }
}