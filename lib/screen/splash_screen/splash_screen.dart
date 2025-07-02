// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:today_news/constant/colors.dart';
import 'package:today_news/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (_) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // colors: [Color(0xFFB71C1C), Color(0xFFFFF8E1)],
            // colors: [Color(0xFF00695C), Color(0xFFE0F2F1)],
            // colors: [Color(0xFF283593), Color(0xFFBBDEFB)],
            // colors: [Color(0xFFFF6F61), Color(0xFFFFDAB9)],
            // colors: [Color(0xFF6A1B9A), Color(0xFFEDE7F6)],
            // colors: [Color(0xFF212121), Color(0xFFBDBDBD)],
            // colors: [Color(0xFFFF8C42), Color(0xFFFFEEDB)],
            // colors: [Color(0xFFFF8C42), Color(0xFFFFD3B6)],
            colors: AllColors.splashColor,
            // colors: [Color(0xFFFF8C42), Color(0xFFF5E4C3)],
            // colors: [Color(0xFFFF8C42), Color(0xFFFFCFCF)],
            // colors: [Color(0xFF2E7D32), Color(0xFFB2DFDB)],
            // colors: [Color(0xFF0D47A1), Color(0xFFE3F2FD)],
            // colors: [Color(0xFF1D3557), Color(0xFFF1FAEE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(Icons.newspaper_rounded, color: Colors.white, size: 100),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.asset('images/splash_pic.jpg'),
                ),
              ),
              SizedBox(height: height * .02),
              Text(
                'Today-News',
                style: TextStyle(
                  color: AllColors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: height * .005),
              Text(
                'Stay updated. Stay ahead.',
                style: TextStyle(color: AllColors.black, fontSize: 16),
              ),
              SizedBox(height: height * .01),
              SpinKitCircle(color: AllColors.black),
            ],
          ),
        ),
      ),
    );
  }
}
