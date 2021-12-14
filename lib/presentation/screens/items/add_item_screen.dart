import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/presentation/widgets/core/button.dart';
import 'package:house_of_auctions/presentation/widgets/core/sliver_app_bar.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  Widget plusButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () async {},
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.blue),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SliverAppBarWidget(
                children: [
                  const SpaceH20(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SpaceW20(),
                        plusButton(),
                        const SpaceW10(),
                        plusButton(),
                        const SpaceW10(),
                        plusButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              width: double.maxFinite,
              child: Column(
                children: [
                  const Divider(),
                  CustomButton(
                    buttonPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    color: AppColors.blue,
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        'Post',
                        style: getTextTheme(context).headline6!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
