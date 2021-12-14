import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/constants/gradients.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;
  final double borderRadius;
  final Widget? child;
  final bool disabled;
  final bool fullWidth;
  final Widget? endIcon;
  final double height;
  final EdgeInsets padding;
  final EdgeInsets buttonPadding;
  final Widget? startIcon;
  final String? text;

  const CustomButton({
    Key? key,
    required this.color,
    required this.onPressed,
    this.borderRadius = 24,
    this.child,
    this.disabled = false,
    this.fullWidth = true,
    this.endIcon,
    this.height = 48,
    this.padding = const EdgeInsets.all(12),
    this.buttonPadding = EdgeInsets.zero,
    this.startIcon,
    this.text,
  }) : super(key: key);

  static final _shadowColor = AppColors.darkGrey.withOpacity(0.1);
  static final _disabledColor = AppColors.darkGrey.withOpacity(0.2);

  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      primary: Colors.white,
      onPrimary: color,
      onSurface: Colors.white,
      padding: EdgeInsets.zero,
      maximumSize: Size(double.infinity, height),
      elevation: 2,
      shadowColor: _shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.subtitle1?.copyWith(
          color: disabled ? _disabledColor : color,
        );
  }

  TextAlign _getTextAlign() {
    var align = TextAlign.center;
    if (startIcon != null) {
      align = TextAlign.end;
    } else if (endIcon != null) {
      align = TextAlign.start;
    }
    return align;
  }

  BoxDecoration _getButtonBackground() {
    return BoxDecoration(
      gradient: !disabled && color != Colors.white
          ? Gradients.getDefaultGradient(
              Gradients.colorToGradient[color] ?? [],
              opacity: 0.75,
            )
          : null,
      color: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  Widget _getStartIcon() {
    if (startIcon != null) {
      return startIcon!;
    } else {
      return const SizedBox(width: 8);
    }
  }

  Widget _getEndIcon() {
    if (endIcon != null) {
      return endIcon!;
    } else {
      return const SizedBox(width: 8);
    }
  }

  Widget _getChild(BuildContext context) {
    if (child != null) {
      return child!;
    } else if (text != null) {
      return Text(
        text!,
        style: _getTextStyle(context),
        textAlign: _getTextAlign(),
      );
    }
    return const SizedBox();
  }

  Widget _getButtonContent(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getStartIcon(),
          Expanded(child: _getChild(context)),
          _getEndIcon(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buttonPadding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: _getButtonStyle(),
          child: Ink(
            decoration: _getButtonBackground(),
            child: _getButtonContent(context),
          ),
        ),
      ),
    );
  }
}
