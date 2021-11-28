import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double size;

  const CustomProgressIndicator({
    Key? key,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: AppColors.green,
      size: size,
    );
  }
}
