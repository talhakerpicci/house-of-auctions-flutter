import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/presentation/widgets/core/cached_network_image.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class ItemSellingCard extends StatelessWidget {
  final Map itemDetail;
  const ItemSellingCard({
    Key? key,
    required this.itemDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Row(
          children: [
            const SpaceW10(),
            SizedBox(
              height: 70,
              width: 70,
              child: CustomCachedNetworkImage(
                url: itemDetail['picture'],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 28),
                          child: Text(
                            itemDetail['name'],
                            overflow: TextOverflow.ellipsis,
                            style: getTextTheme(context).subtitle1!.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                        const SpaceH4(),
                        Text(
                          itemDetail['price'],
                          style: getTextTheme(context).bodyText1!.copyWith(
                                color: AppColors.darkGrey,
                              ),
                        ),
                        const SpaceH4(),
                        Text(
                          'Number of bids: ${itemDetail['numOfBids']}',
                          style: getTextTheme(context).bodyText1!.copyWith(
                                color: AppColors.darkGrey,
                              ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
