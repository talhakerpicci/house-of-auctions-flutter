import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:house_of_auctions/domain/models/item/item_model.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';
import 'package:house_of_auctions/presentation/widgets/core/cached_network_image.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  const ItemCard({
    Key? key,
    required this.item,
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
        onTap: () {
          context.router.push(FeedItemDetailScreenRoute(item: item));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: item.name,
                  child: Image.network(
                    'http://192.168.0.24:4242/get-item-images/${item.userId}/${item.id}',
                  ),

                  /* CustomCachedNetworkImage(
                    url: 
                    'http://192.168.0.24:4242/get-item-images',
                    boxFit: BoxFit.contain,
                  ), */
                ),
              ),
              Container(
                color: AppColors.blue.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 30,
                child: Row(
                  children: [
                    const Icon(
                      Icons.bolt,
                      color: Colors.white,
                    ),
                    Text(
                      '${item.initialPrice}',
                      style: getTextTheme(context).bodyText1!.copyWith(
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
