import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/presentation/widgets/core/cached_network_image.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class ItemSellingCard extends StatelessWidget {
  const ItemSellingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Row(
          children: [
            const SpaceW10(),
            const SizedBox(
              height: 70,
              width: 70,
              child: CustomCachedNetworkImage(
                url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjefFODtEBb6DmzzXDGw1nktatDmcRnaUbFRzOfWb4ouztBjVSxa9YYA0XKpbezu8oTLw&usqp=CAU',
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
                        Text(
                          'Dell Gaming G15 5510',
                          style: getTextTheme(context).subtitle1!.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SpaceH4(),
                        Text(
                          '9.850 TL',
                          style: getTextTheme(context).bodyText1!.copyWith(
                                color: AppColors.darkGrey,
                              ),
                        ),
                        const SpaceH4(),
                        Text(
                          'Number of Bids: 20',
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
