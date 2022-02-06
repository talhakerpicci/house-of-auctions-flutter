import 'package:flutter/material.dart';
import 'package:house_of_auctions/domain/models/item/item_model.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/constants/di.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/modules/token_storage/token_storage.dart';
import 'package:house_of_auctions/presentation/widgets/core/progress_indicator.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class ItemSellingCard extends StatelessWidget {
  final ItemModel item;
  const ItemSellingCard({
    Key? key,
    required this.item,
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
              child: Image.network(
                '${env.apiBaseUrl}/get-item-image/${item.userId}/${item.id}',
                headers: {'Authorization': 'Bearer ${getIt<HiveTokenStorage>().read()!.accessToken}'},
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Container(
                      color: Colors.white,
                      child: const Center(
                        child: CustomProgressIndicator(
                          size: 30,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: child,
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                fit: BoxFit.cover,
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
                        /* Padding(
                          padding: const EdgeInsets.only(right: 28),
                          child: Text(
                            item.name,
                            overflow: TextOverflow.ellipsis,
                            style: getTextTheme(context).subtitle1!.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ), */
                        Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                          style: getTextTheme(context).subtitle1!.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SpaceH4(),
                        Text(
                          'Initial Price: ${item.initialPrice.toString()}',
                          style: getTextTheme(context).bodyText1!.copyWith(
                                color: AppColors.darkGrey,
                              ),
                        ),
                        const SpaceH4(),
                        Text(
                          'Highest Bid: ${item.currentBid.toString()}',
                          style: getTextTheme(context).bodyText1!.copyWith(
                                color: AppColors.darkGrey,
                              ),
                        ),
                      ],
                    ),
                    /* Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ), */
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
