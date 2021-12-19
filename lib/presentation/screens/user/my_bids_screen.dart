import 'package:flutter/material.dart';

class MyBidsScreen extends StatelessWidget {
  const MyBidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Bids'),
      ),
      body: const Center(
        child: Text('My Bids'),
      ),
    );
  }
}
