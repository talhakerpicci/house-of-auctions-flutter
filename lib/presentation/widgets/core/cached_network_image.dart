import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:house_of_auctions/presentation/widgets/core/progress_indicator.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit boxFit;
  final double borderRadius;

  const CustomCachedNetworkImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.boxFit = BoxFit.cover,
    this.borderRadius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
          color: Colors.white,
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        color: Colors.white,
        child: const Center(
          child: CustomProgressIndicator(
            size: 30,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
