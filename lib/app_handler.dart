import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/log/log_it.dart';
import 'package:house_of_auctions/infrastructure/core/modules/router/router.gr.dart';

class AppHandler extends StatefulWidget {
  const AppHandler({
    Key? key,
    required this.screen,
    required this.navigatorKey,
  }) : super(key: key);

  final Widget screen;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  _AppHandlerState createState() => _AppHandlerState();
}

class _AppHandlerState extends State<AppHandler> {
  bool isInitialRun = true;
  @override
  Widget build(BuildContext context) {
    // displays an any overlay in order to block or inform the user
    // in any active page according to the appState.
    return _authHandler(); /* MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            _handleLoadingNAlert(state: state);
          },
        ),
      ],
      child: _authHandler(),
    ); */
  }

  void _handleLoadingNAlert({required dynamic state}) {
    /* if (state is AuthLoading) {
      _showOverlay(widget.navigatorKey.currentState!.overlay!);
    } else {
      _hideOverlay();
    }



    if (state is AuthFailed) {
      BarHelper.showAlert(
        widget.navigatorKey.currentContext!,
        // ignore: avoid_dynamic_calls
        alert: state.alert,
      );
    } */
  }

  // listens auth status in order to navigate the user
  // in any active page according to the authState.
  Widget _authHandler() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (isInitialRun) {
        AutoRouter.of(widget.navigatorKey.currentContext!).replace(
          const WelcomeScreenRoute(),
        );
        isInitialRun = false;
      }
    });

    getIt<LogIt>().error(isInitialRun);

    return widget.screen; /* BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          AutoRouter.of(widget.navigatorKey.currentContext!).replace(
            const AppNavigatorRoute(),
          );
        } else if (state is Unauthenticated) {
          AutoRouter.of(widget.navigatorKey.currentContext!).replace(
            const LoginScreenRoute(),
          );
        }
      },
      child: widget.screen,
    ); */
  }
}
