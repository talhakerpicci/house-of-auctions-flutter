import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/add_item/add_item_provider.dart';
import 'package:house_of_auctions/application/user/user_provider.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/item/item_model.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/bar/bar_helper.dart';
import 'package:house_of_auctions/infrastructure/core/modules/image_picker/custom_image_picker.dart';
import 'package:house_of_auctions/presentation/widgets/core/button.dart';
import 'package:house_of_auctions/presentation/widgets/core/custom_loading_overlay_widget.dart';
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
  ItemModel item = ItemModel.initial();
  bool isLoading = false;

  final _form = GlobalKey<FormState>();

  final FocusNode itemNameFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode initialPriceFocusNode = FocusNode();

  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController initialPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    itemNameController.value = TextEditingValue(text: item.name, selection: itemNameController.selection);
    descriptionController.value = TextEditingValue(text: item.description, selection: descriptionController.selection);
    initialPriceController.value = TextEditingValue(
        text: item.initialPrice == 0 ? '' : item.initialPrice.toString(), selection: initialPriceController.selection);
  }

  Future<Map<String, dynamic>?> _settingModalBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: AppColors.blue,
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            Column(
              children: <Widget>[
                const SpaceH14(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Profile Photo',
                      style: getTextTheme(context).headline6!.copyWith(
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SpaceH14(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 90,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.photo_size_select_actual,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              Navigator.pop(context, 'galerry');
                              /* if (await Permission.storage.request().isGranted) {
                                final file = await getIt<CustomImagePicker>().pickImage(source: ImageSource.gallery);
                                await ref.read(userInfoStateNotifierProvider.notifier).updateUserPicture(file: file!);

                                /* await getIt<IItemsRepository>().uplaodPicture(
                                    file: file!,
                                    location: 'users',
                                    itemId: '12',
                                  );
                                }, */
                              } else if (await Permission.storage.isPermanentlyDenied) {
                                /* if (state) {
                                  await openAppSettings();
                                } */
                              } */
                            },
                          ),
                          Text(
                            'Choose From\nGallery',
                            textAlign: TextAlign.center,
                            style: getTextTheme(context).bodyText1!.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SpaceW10(),
                    SizedBox(
                      width: 90,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.camera,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              Navigator.pop(context, 'camera');
                              /* Navigator.pop(context);
                              if (await Permission.camera.request().isGranted) {
                              } else if (await Permission.camera.isPermanentlyDenied) {
                                /* if (state) {
                                  await openAppSettings();
                                } */
                              } */
                            },
                          ),
                          Text(
                            'Take\nPhoto',
                            textAlign: TextAlign.center,
                            style: getTextTheme(context).bodyText1!.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SpaceW10(),
                    SizedBox(
                      width: 90,
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              Navigator.pop(context, 'delete');
                            },
                          ),
                          Text(
                            'Delete\nPhoto',
                            textAlign: TextAlign.center,
                            style: getTextTheme(context).bodyText1!.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
              ],
            ),
          ],
        );
      },
    );
    if (result == 'galerry') {
      final file = await getIt<CustomImagePicker>().pickImage(source: ImageSource.gallery);
      return {'operation': 'galerry', 'file': file};
    } else if (result == 'camera') {
      final file = await getIt<CustomImagePicker>().pickImage(source: ImageSource.camera);
      return {'operation': 'camera', 'file': file};
    } else if (result == 'delete') {
      return {'operation': 'delete', 'file': null};
    }
    return {};
  }

  Widget plusButton({XFile? image, int? index}) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () async {
        final result = await _settingModalBottomSheet(context);

        if (result != null) {
          if (result['operation'] == 'delete') {
            try {
              setState(() {
                images.removeAt(index!);
              });
            } catch (e) {
              return;
            }
          } else {
            if (index != null) {
              setState(() {
                images[index] = result['file'];
              });
            } else {
              setState(() {
                images.add(result['file']);
              });
            }
          }
        }
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: AppColors.blue),
        ),
        child: image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(image.path),
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(
                Icons.add,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomLoadingOverlayWidget(
          opacity: 0.5,
          isLoading: isLoading,
          child: Column(
            children: [
              Form(
                key: _form,
                child: Expanded(
                  child: SliverAppBarWidget(
                    children: [
                      const SpaceH20(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SpaceW20(),
                            for (var i = 0; i < images.length; i++) ...{
                              plusButton(image: images[i], index: i),
                              const SpaceW10(),
                            },
                            if (images.length == 3) const SizedBox() else plusButton(),
                          ],
                        ),
                      ),
                      const SpaceH40(),
                      CustomTextField(
                        width: getSize(context).width,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText: 'Title',
                        maxLength: 100,
                        prefixIcon: const Icon(Icons.title),
                        focusNode: itemNameFocusNode,
                        controller: itemNameController,
                        onChanged: (String value) {
                          item = item.copyWith(
                            name: value,
                          );
                        },
                        onFieldSubmitted: (_) {
                          requestFocus(context, descriptionFocusNode);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Item name cant be empty';
                          }
                          return null;
                        },
                      ),
                      const SpaceH10(),
                      CustomTextField(
                        keyboardType: TextInputType.multiline,
                        width: getSize(context).width,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText: 'Description',
                        maxLength: 1000,
                        maxLines: null,
                        prefixIcon: const Icon(Icons.title),
                        focusNode: descriptionFocusNode,
                        controller: descriptionController,
                        onChanged: (String value) {
                          item = item.copyWith(
                            description: value,
                          );
                        },
                        onFieldSubmitted: (_) {
                          requestFocus(context, initialPriceFocusNode);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description cant be empty';
                          }
                          return null;
                        },
                      ),
                      const SpaceH10(),
                      CustomTextField(
                        width: getSize(context).width,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText: 'Initial Price',
                        prefixIcon: const Icon(Icons.monetization_on_outlined),
                        focusNode: initialPriceFocusNode,
                        controller: initialPriceController,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          item = item.copyWith(
                            initialPrice: double.parse(value),
                          );
                        },
                        onFieldSubmitted: (_) {
                          unFocus();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Initial price cant be empty';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
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
                      onPressed: () async {
                        final isValid = _form.currentState!.validate();
                        if (!isValid) {
                          return;
                        }

                        if (images.isEmpty) {
                          BarHelper.showAlert(context,
                              alert: const AlertModel(message: 'At least one image required', type: AlertType.error));
                          return;
                        }

                        setState(() {
                          isLoading = true;
                        });

                        final userId = (ref.read(userStateNotifierProvider) as UserLoaded).user.id;

                        item = item.copyWith(
                          userId: userId,
                          startDate: DateTime.now().toString(),
                          endDate: DateTime.now().add(const Duration(days: 2)).toString(),
                        );

                        await ref.read(addItemStateNotifierProvider.notifier).addItem(
                              item: item,
                              files: images,
                            );

                        /* setState(() {
                          isLoading = false;
                        }); */
                      },
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
      ),
    );
  }
}
