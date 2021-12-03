import 'package:flutter/material.dart';
import 'package:house_of_auctions/presentation/widgets/core/progress_indicator.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final double opacity;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double indicatorStrokeWidth;
  final Widget? centerWidget;

  const LoadingOverlayWidget({Key? key, required this.opacity, this.width = 100, this.height = 100, this.backgroundColor, this.indicatorColor, this.indicatorStrokeWidth = 2, this.centerWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Opacity(
        opacity: opacity,
        child: Container(
          color: backgroundColor ?? Colors.black.withOpacity(0.6),
          child: const Center(
            child: CustomProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
