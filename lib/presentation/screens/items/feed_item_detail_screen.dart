import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:house_of_auctions/domain/models/item/item_model.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/constants/di.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/modules/token_storage/token_storage.dart';
import 'package:house_of_auctions/presentation/widgets/core/button.dart';
import 'package:house_of_auctions/presentation/widgets/core/progress_indicator.dart';
import 'package:house_of_auctions/presentation/widgets/core/text_field.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class FeedItemDetailScreen extends StatefulWidget {
  final ItemModel item;
  const FeedItemDetailScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<FeedItemDetailScreen> createState() => _FeedItemDetailScreenState();
}

class _FeedItemDetailScreenState extends State<FeedItemDetailScreen> {
  int currentUrl = 0;
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 3; i++) {
      images.add('${env.apiBaseUrl}/get-item-images/${widget.item.userId}/${widget.item.id}/$i');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: images.length,
                        options: CarouselOptions(
                          height: getSize(context).height * 0.5,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentUrl = index;
                            });
                          },
                        ),
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Image.network(
                          images[itemIndex],
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
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: images.map(
                              (url) {
                                final index = images.indexOf(url);
                                return Container(
                                  width: 8,
                                  height: 8,
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentUrl == index ? Colors.white : const Color.fromRGBO(0, 0, 0, 0.4),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: 8,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: const ShapeDecoration(
                              color: Colors.black45,
                              shape: CircleBorder(),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SpaceH10(),
                        Text(
                          '${widget.item.initialPrice}',
                          style: getTextTheme(context).headline3,
                        ),
                        const SpaceH4(),
                        Text(
                          widget.item.name,
                          style: getTextTheme(context).headline2,
                        ),
                        const SpaceH10(),
                        Row(
                          children: [
                            //Date and num of bids here
                          ],
                        ),
                        Text(widget.item.description),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BottomAppBar(
              child: SizedBox(
                height: 80,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomTextField(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText: 'Amount',
                        /* focusNode: passwordFocusNode,
                                      controller: passwordController, */
                        prefixIcon: const Icon(Icons.monetization_on),
                        onChanged: (String value) {},
                        onFieldSubmitted: (_) {
                          unFocus();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cant be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 165,
                      height: 50,
                      child: CustomButton(
                        buttonPadding: const EdgeInsets.only(
                          right: 20,
                        ),
                        color: AppColors.blue,
                        onPressed: () {},
                        child: Center(
                          child: Text(
                            'Make a Bid',
                            style: getTextTheme(context).headline6!.copyWith(
                                  color: Colors.white,
                                ),
                          ),
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
