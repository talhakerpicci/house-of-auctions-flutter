import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_auctions/application/authentication/auth_provider.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/bar/bar_helper.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/log/log_it.dart';
import 'package:house_of_auctions/infrastructure/core/modules/data_storage/data_storage.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';
import 'package:house_of_auctions/presentation/widgets/core/loading_overlay_widget.dart';

class AppHandler extends ConsumerStatefulWidget {
  const AppHandler({Key? key}) : super(key: key);

  @override
  _AppHandlerState createState() => _AppHandlerState();
}

class _AppHandlerState extends ConsumerState<AppHandler> with TickerProviderStateMixin {
  OverlayEntry? overlayEntry;
  OverlayState? overlayState;
  final data = getIt<HiveDataStorage>().read();
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    // inits variables
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _authHandler();
  }

  void listenProviders() {
    ref.listen(authStateNotifierProvider, (stateBefore, stateAfter) {
      getIt<LogIt>().info(stateAfter);
      _handleLoadingNAlert(
        isLoading: stateAfter is AuthLoading,
        error: stateAfter is AuthFailed ? stateAfter.alert : null,
      );

      if (stateAfter is Authenticated) {
        AutoRouter.of(context).replaceAll(
          [
            const AppNavigatorRoute(),
          ],
        );
        Future.delayed(const Duration(milliseconds: 100)).then((value) {
          if (stateAfter.alert != null) {
            BarHelper.showAlert(
              AutoRouter.of(context).navigatorKey.currentContext!,
              alert: stateAfter.alert!,
              showAboveBottomBar: true,
            );
          }
        });
      } else if (stateAfter is Unauthenticated && data.skipIntro) {
        AutoRouter.of(context).replaceAll(
          [
            const WelcomeScreenRoute(),
          ],
        );
      }
    });
  }

  Widget _authHandler() {
    if (!data.skipIntro) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        AutoRouter.of(context).replaceAll(
          [
            const IntroScreenRoute(),
          ],
        );
      });
    }
    listenProviders();
    return const AutoRouter();
  }

  void _handleLoadingNAlert({
    required bool isLoading,
    required AlertModel? error,
  }) {
    if (isLoading) {
      _showOverlay();
    } else {
      _hideOverlay();
    }

    if (error != null) {
      BarHelper.showAlert(
        AutoRouter.of(context).navigatorKey.currentContext!,
        alert: error,
      );
    }
  }

  void _showOverlay() {
    overlayState = overlayState = AutoRouter.of(context).navigatorKey.currentState!.overlay;
    overlayEntry = OverlayEntry(
      builder: (context) => LoadingOverlayWidget(opacity: animation.value),
    );

    animationController.addListener(() {
      overlayState!.setState(() {});
    });

    overlayState!.insert(overlayEntry!);
    animationController.forward();
  }

  void _hideOverlay() {
    if (overlayEntry != null) {
      animationController.reverse().whenComplete(() {
        if (overlayEntry!.mounted) {
          overlayEntry!.remove();
        }
      });
    }
  }
}
