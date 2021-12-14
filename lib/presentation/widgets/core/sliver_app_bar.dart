import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SliverAppBarWidget extends StatelessWidget {
  final List<Widget> children;
  const SliverAppBarWidget({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          leading: IconButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            icon: const Icon(Icons.close),
            color: Colors.black,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          expandedHeight: 120,
          flexibleSpace: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
                final deltaExtent = settings.maxExtent - settings.minExtent;
                final scrollingRate = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent).clamp(0.0, 1.0);
                return Padding(
                  padding: EdgeInsets.only(bottom: 14, left: 12 + 40 * scrollingRate),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Listing details',
                      style: TextStyle(fontSize: 36 - 12 * scrollingRate, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return children[index];
            },
            childCount: children.length,
          ),
        )
      ],
    );
  }
}
