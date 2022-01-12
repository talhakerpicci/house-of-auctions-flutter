import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/domain/interfaces/i_items_repository.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/modules/api_client/api_client.dart';
import 'package:house_of_auctions/infrastructure/core/modules/image_picker/custom_image_picker.dart';
import 'package:house_of_auctions/infrastructure/repositories/items_repository.dart';
import 'package:house_of_auctions/presentation/widgets/core/button.dart';
import 'package:house_of_auctions/presentation/widgets/core/sliver_app_bar.dart';
import 'package:house_of_auctions/presentation/widgets/core/text_field.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  List<XFile> images = [];

  Widget plusButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () async {
        final file = await getIt<CustomImagePicker>().pickImage(source: ImageSource.gallery);
        
        await getIt<IItemsRepository>().uplaodPicture(file!, '1');
      },
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SpaceW20(),
                            plusButton(),
                            const SpaceW10(),
                            plusButton(),
                            const SpaceW10(),
                            plusButton(),
                          ],
                        ),
                        const SpaceH40(),
                        CustomTextField(
                          width: getSize(context).width,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          hintText: 'Title',
                          prefixIcon: const Icon(Icons.title),
                          /* focusNode: emailFocusNode,
                          controller: emailController, */
                          onChanged: (String value) {
                            /* email = value; */
                          },
                          onFieldSubmitted: (_) {
                            /* requestFocus(context, passwordFocusNode); */
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cant be empty';
                            }
                            return null;
                          },
                        ),
                        const SpaceH10(),
                        CustomTextField(
                          width: getSize(context).width,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          hintText: 'Description',
                          prefixIcon: const Icon(Icons.title),
                          /* focusNode: emailFocusNode,
                          controller: emailController, */
                          onChanged: (String value) {
                            /* email = value; */
                          },
                          onFieldSubmitted: (_) {
                            /* requestFocus(context, passwordFocusNode); */
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cant be empty';
                            }
                            return null;
                          },
                        ),
                        const SpaceH10(),
                        CustomTextField(
                          width: getSize(context).width,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          hintText: 'Initial Price',
                          prefixIcon: const Icon(Icons.title),
                          /* focusNode: emailFocusNode,
                          controller: emailController, */
                          onChanged: (String value) {
                            /* email = value; */
                          },
                          onFieldSubmitted: (_) {
                            /* requestFocus(context, passwordFocusNode); */
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cant be empty';
                            }
                            return null;
                          },
                        ),
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
