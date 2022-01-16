import 'package:flutter/material.dart';
import 'package:house_of_auctions/presentation/widgets/spaces.dart';

class EmptyScreen extends StatelessWidget {
  final String message;
  final IconData icon;
  const EmptyScreen({
    Key? key,
    required this.message,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 120,
            height: 100,
            child: Icon(
              icon,
              size: 100,
            ),
          ),
          const SpaceH20(),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
