import 'package:flutter/material.dart';
import 'package:today_news/constant/colors.dart';
import 'package:today_news/network_manager/rest_client.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AllColors.splashColor,
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: const [0.1, 0.9],
              tileMode: TileMode.clamp,
              transform: GradientRotation(90),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Home'),
            actions: [
              IconButton(
                onPressed: () async {
                  await RestClient().getHeadlineNews();
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
