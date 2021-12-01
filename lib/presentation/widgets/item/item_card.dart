import 'package:flutter/material.dart';
import 'package:house_of_auctions/presentation/widgets/core/cached_network_image.dart';

class ItemCard extends StatelessWidget {
  final String url;
  const ItemCard({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.7),
            blurRadius: 1,
            spreadRadius: 1.5,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: () async {},
          child: Hero(
            tag: url,
            child: CustomCachedNetworkImage(
              url: url,
              boxFit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
