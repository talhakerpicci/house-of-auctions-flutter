import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/helpers/app_helper_functions.dart';
import 'package:house_of_auctions/presentation/widgets/core/sliver_app_bar.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SliverAppBarWidget(
                children: [
                  ListTile(
                    title: Text('asdas'),
                  ),
                  Container(
                    height: 60,
                    width: 40,
                    color: Colors.red,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('button')),
                  ListTile(
                    title: Text('asdas'),
                  ),
                  ListTile(
                    title: Text('asdas'),
                  ),
                  ListTile(
                    title: Text('asdas'),
                  ),
                  ListTile(
                    title: Text('asdas'),
                  ),
                  ListTile(
                    title: Text('asdas'),
                  ),
                  ListTile(
                    title: Text('asdas'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Post'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
