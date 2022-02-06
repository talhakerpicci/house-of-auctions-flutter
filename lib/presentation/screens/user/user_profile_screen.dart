import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/authentication/auth_provider.dart';
import 'package:house_of_auctions/application/user/user_provider.dart';
import 'package:house_of_auctions/application/user_info/user_info_provider.dart';
import 'package:house_of_auctions/domain/models/user/user_model.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/infrastructure/core/constants/di.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/bar/bar_helper.dart';
import 'package:house_of_auctions/infrastructure/core/modules/image_picker/custom_image_picker.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';
import 'package:house_of_auctions/infrastructure/core/modules/token_storage/token_storage.dart';
import 'package:house_of_auctions/presentation/widgets/core/progress_indicator.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  String nowParam = DateFormat('yyyyddMMHHmm').format(DateTime.now());
  Future<void> _settingModalBottomSheet(BuildContext context) async {
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
      await ref.read(userInfoStateNotifierProvider.notifier).updateUserPicture(file: file!);
    } else if (result == 'camera') {
      final file = await getIt<CustomImagePicker>().pickImage(source: ImageSource.camera);
      await ref.read(userInfoStateNotifierProvider.notifier).updateUserPicture(file: file!);
    } else if (result == 'delete') {
      final userId = (ref.read(userStateNotifierProvider) as UserLoaded).user.id;
      await ref.read(userInfoStateNotifierProvider.notifier).removeUserPicture(userId: userId.toString());
    }
  }

  Widget buildPicture({required bool isLoading, required UserModel user}) {
    final token = getIt<HiveTokenStorage>().read();

    return Image.network(
      '${env.apiBaseUrl}/get-user-image/${user.id}#$nowParam',
      headers: {'Authorization': 'Bearer ${token!.accessToken}'},
      key: const ValueKey(1),
      /* ValueKey(
        '${env.apiBaseUrl}/get-user-image/${user.id}',
      ), */
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userStateNotifierProvider);
    final user = state is UserLoaded ? state.user : UserModel.initial();

    ref.listen(userInfoStateNotifierProvider, (stateBefore, stateAfter) {
      if (stateAfter is UserInfoSuccess) {
        Navigator.pop(context);
        ref.read(userStateNotifierProvider.notifier).updateLocalUser(newUserData: stateAfter.user);
        BarHelper.showAlert(
          context,
          alert: stateAfter.alert,
          position: FlushbarPosition.TOP,
        );
      } else if (stateAfter is UserInfoFailed) {
        BarHelper.showAlert(context, alert: stateAfter.alert);
      }
    });

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
                                onTap: () async {
                                  await _settingModalBottomSheet(context);
                                  setState(() {
                                    nowParam = DateFormat('yyyyddMMHHmm').format(DateTime.now());
                                  });
                                },
                                child: WidgetCircularAnimator(
                                  innerColor: AppColors.blue,
                                  outerColor: AppColors.red,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    margin: const EdgeInsets.all(8),
                                    child: ClipOval(
                                      child: buildPicture(
                                        isLoading: state is UserLoading,
                                        user: user,
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
                        onTap: () {
                          context.router.push(UpdateNameScreenRoute(nameSurname: user.nameSurname));
                        },
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
                                  user.nameSurname,
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
                          await _settingModalBottomSheet(context);
                          setState(() {
                            nowParam = DateFormat('yyyyddMMHHmm').format(DateTime.now());
                          });
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
                        /* onTap: () {
                          context.router.push(const UpdateEmailScreenRoute());
                        }, */
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
                                  user.email,
                                  overflow: TextOverflow.ellipsis,
                                  style: getTextTheme(context).bodyText1!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            /* const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                            const SpaceW12(), */
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
                          context.router.push(const UpdatePasswordScreenRoute());
                        },
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
