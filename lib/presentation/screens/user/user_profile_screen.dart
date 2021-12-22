import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/authentication/auth_provider.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/presentation/widgets/core/cached_network_image.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
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
                              Navigator.pop(context);
                              if (await Permission.storage.request().isGranted) {
                              } else if (await Permission.storage.isPermanentlyDenied) {
                                /* if (state) {
                                  await openAppSettings();
                                } */
                              }
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
                              Navigator.pop(context);
                              if (await Permission.camera.request().isGranted) {
                              } else if (await Permission.camera.isPermanentlyDenied) {
                                /* if (state) {
                                  await openAppSettings();
                                } */
                              }
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
                              Navigator.pop(context);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/auct.jpg',
                height: 240,
                width: getSize(context).width,
                fit: BoxFit.fill,
              ),
              Container(
                height: 240,
                padding: EdgeInsets.zero,
                alignment: Alignment.topLeft,
                child: const SafeArea(
                  child: BackButton(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 190),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 42,
                          child: ClipOval(
                            child: Container(
                              width: 90,
                              height: 90,
                              color: Colors.white,
                              child: GestureDetector(
                                onTap: () {
                                  _settingModalBottomSheet(context);
                                },
                                child: WidgetCircularAnimator(
                                  innerColor: AppColors.blue,
                                  outerColor: AppColors.red,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    margin: const EdgeInsets.all(8),
                                    child: const ClipOval(
                                      child: CustomCachedNetworkImage(
                                        url: 'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/male/45.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SpaceH24(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 42,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.lightGrey,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {},
                        child: Row(
                          children: <Widget>[
                            const SpaceW12(),
                            const Icon(
                              Icons.person,
                              size: 18,
                            ),
                            const SpaceW20(),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(top: 2),
                                margin: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'Talha Kerpicci',
                                  overflow: TextOverflow.ellipsis,
                                  style: getTextTheme(context).bodyText1!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                            const SpaceW12(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SpaceH12(),
                  Container(
                    height: 42,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.lightGrey,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          _settingModalBottomSheet(context);
                        },
                        child: Row(
                          children: <Widget>[
                            const SpaceW12(),
                            const Icon(
                              Icons.camera,
                              size: 18,
                            ),
                            const SpaceW20(),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(top: 2),
                                margin: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'Profile Picture',
                                  overflow: TextOverflow.ellipsis,
                                  style: getTextTheme(context).bodyText1!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                            const SpaceW12(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SpaceH12(),
                  Container(
                    height: 42,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.lightGrey,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {},
                        child: Row(
                          children: <Widget>[
                            const SpaceW12(),
                            const Icon(
                              Icons.email,
                              size: 18,
                            ),
                            const SpaceW20(),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(top: 2),
                                margin: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'talha.kerpicci@gmail.com',
                                  overflow: TextOverflow.ellipsis,
                                  style: getTextTheme(context).bodyText1!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                            const SpaceW12(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SpaceH12(),
                  Container(
                    height: 42,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.lightGrey,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {},
                        child: Row(
                          children: <Widget>[
                            const SpaceW12(),
                            const Icon(
                              Icons.vpn_key,
                              size: 18,
                            ),
                            const SpaceW20(),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(top: 2),
                                margin: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'Change Password',
                                  overflow: TextOverflow.ellipsis,
                                  style: getTextTheme(context).bodyText1!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                            const SpaceW12(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SpaceH12(),
                  Container(
                    height: 42,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.lightGrey,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async {
                          await ref.read(authStateNotifierProvider.notifier).logout();
                        },
                        child: Row(
                          children: <Widget>[
                            const SpaceW12(),
                            const Icon(
                              Icons.exit_to_app,
                              size: 18,
                            ),
                            const SpaceW20(),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(top: 2),
                                margin: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'Log out',
                                  overflow: TextOverflow.ellipsis,
                                  style: getTextTheme(context).bodyText1!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                            const SpaceW12(),
                          ],
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
    );
  }
}
