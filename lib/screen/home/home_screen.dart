import 'package:flutter/material.dart';
import 'package:today_news/network_manager/rest_client.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [IconButton(onPressed: ()async {
          await RestClient().getHeadlineNews();
        }, icon: const Icon(Icons.search))],
      ),
    );
  }
}
