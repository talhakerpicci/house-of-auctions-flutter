import 'package:flutter/material.dart';
import 'package:house_of_auctions/presentation/widgets/core/progress_indicator.dart';

class CustomLoadingOverlayWidget extends StatelessWidget {
  final double opacity;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double indicatorStrokeWidth;
  final Widget? centerWidget;
  final bool isLoading;
  final Widget child;

  const CustomLoadingOverlayWidget({
    Key? key,
    required this.opacity,
    required this.isLoading,
    required this.child,
    this.width = 100,
    this.height = 100,
    this.backgroundColor,
    this.indicatorColor,
    this.indicatorStrokeWidth = 2,
    this.centerWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          child,
          if (isLoading)
            Opacity(
              opacity: opacity,
              child: Container(
                color: backgroundColor ?? Colors.black.withOpacity(0.6),
                child: const Center(
                  child: CustomProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
