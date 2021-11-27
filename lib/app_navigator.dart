import 'package:flutter/material.dart';
import 'package:house_of_auctions/application/app/app_provider.dart';
import 'package:house_of_auctions/infrastructure/core/di/di.dart';
import 'package:house_of_auctions/presentation/widgets/core/bottom_nav_bar.dart';
import 'package:house_of_auctions/presentation/widgets/core/search_app_bar_widget.dart';
import 'package:provider/provider.dart';

enum NavigatorIndex { assets, tasks, requests, notifications }

class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, value, __) {
        return Scaffold(
          appBar: const SearchAppbarWidget(),
          body: _getBodyViews().elementAt(value.pageIndex),
          bottomNavigationBar: BottomNavigationBarWidget(
            pageIndex: value.pageIndex,
          ),
        );
      },
    );
  }

  List<Widget> _getBodyViews() {
    return [
      const Center(
        child: Text('Feed'),
      ),
      const Center(
        child: Text('Following'),
      ),
      const SizedBox(),
      const Center(
        child: Text('Inbox'),
      ),
      const Center(
        child: Text('My Listings'),
      ),
    ];
  }
}
