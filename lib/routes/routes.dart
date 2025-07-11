import 'package:today_news/screen/auth/login/login_screen.dart';
import 'package:today_news/screen/auth/signup/signup_screen.dart';
import 'package:today_news/screen/category/category_screen.dart';
import 'package:today_news/screen/detail/detail_screen.dart';
import 'package:today_news/screen/home/home_screen.dart';

import 'routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        );
      case RoutesName.signup:
        return MaterialPageRoute(
          builder: (BuildContext context) => SignUpScreen(),
        );

      case RoutesName.detail:
        var args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (BuildContext context) => DetailScreen(
            author: args['author'],
            title: args['title'],
            description: args['description'],
            url: args['url'],
            urlToImage: args['urlToImage'],
            publishedAt: args['publishedAt'],
            content: args['content'],
          ),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        );
      case RoutesName.category:
        return MaterialPageRoute(
          builder: (BuildContext context) => CategoryScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No Route Found"))),
        );
    }
  }
}
