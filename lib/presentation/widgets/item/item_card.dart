import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
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
      child: GestureDetector(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: url,
                  child: CustomCachedNetworkImage(
                    url: url,
                    boxFit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                color: AppColors.blue.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                child: Row(
                  children: [
                    const Icon(
                      Icons.bolt,
                      color: Colors.white,
                    ),
                    Text(
                      '9.5900 TL',
                      style: getTextTheme(context).subtitle1!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
