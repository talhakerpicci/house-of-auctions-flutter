import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? initialValue;
  final TextCapitalization? textCapitalization;
  final int? maxLength;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final TextAlign? textAlign;
  final String? hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final TextStyle textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool digitsOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    this.initialValue,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    required this.onChanged,
    this.padding,
    this.validator,
    this.contentPadding,
    this.height,
    this.width,
    this.textAlign = TextAlign.start,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.textStyle = const TextStyle(
      color: Colors.black,
    ),
    this.prefixIcon,
    this.hintStyle,
    this.digitsOnly = false,
    this.inputFormatters,
    this.labelStyle,
    this.labelText,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: CHANGE HEIGHT. TRY TO MAKE BIGGER
    return Container(
      padding: padding,
      width: width,
      color: Colors.transparent,
      child: TextFormField(
        controller: controller,
        textCapitalization: textCapitalization!,
        initialValue: initialValue,
        textInputAction: textInputAction,
        textAlign: textAlign!,
        focusNode: focusNode,
        keyboardType: keyboardType,
        onFieldSubmitted: onFieldSubmitted,
        cursorColor: Colors.grey,
        maxLength: maxLength,
        style: textStyle,
        obscureText: obscureText,
        inputFormatters: inputFormatters ??
            <TextInputFormatter>[
              if (digitsOnly)
                FilteringTextInputFormatter.digitsOnly
              else
                TextInputFormatter.withFunction(
                  (oldValue, newValue) => newValue,
                ),
            ],
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelStyle: const TextStyle(color: Colors.grey),
          contentPadding: contentPadding,
          isDense: true,
          filled: true,
          fillColor: AppColors.lightGrey2,
          hoverColor: Colors.grey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 10),
          hintText: hintText,
          hintStyle: hintStyle,
          labelText: labelText,
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
