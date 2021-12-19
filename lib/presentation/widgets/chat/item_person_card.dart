import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';
import 'package:house_of_auctions/presentation/widgets/core/cached_network_image.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class ItemPersonCard extends StatelessWidget {
  final Map personData;
  const ItemPersonCard({
    Key? key,
    required this.personData,
  }) : super(key: key);

  Widget itemPicture() {
    return Positioned(
      left: 0,
      child: SizedBox(
        height: 60,
        width: 60,
        child: CustomCachedNetworkImage(
          url: personData['itemPicture'],
        ),
      ),
    );
  }

  Widget personPicture() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: ClipOval(
        child: Container(
          height: 35,
          width: 35,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: ClipOval(
              child: CustomCachedNetworkImage(
                url: personData['avatar'],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      height: 90,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            context.router.push(ChatDetailScreenRoute(personData: personData));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 4,
                color: AppColors.blue,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 70,
                            height: 63,
                            child: Stack(
                              children: [
                                itemPicture(),
                                personPicture(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        personData['item'],
                                        style: getTextTheme(context).subtitle1!.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        '11/10/21',
                                        style: getTextTheme(context).bodyText1,
                                      ),
                                    ],
                                  ),
                                  const SpaceH8(),
                                  Text(
                                    personData['nameSurname'],
                                    style: getTextTheme(context).bodyText1!.copyWith(
                                          color: AppColors.darkGrey,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
