import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_news/helper/storage_helper/storage_helper.dart';
import 'package:today_news/provider/auth_provider/auth_provider.dart';
import 'package:today_news/provider/category_news_provider.dart';
import 'package:today_news/provider/top-headline_provider.dart';
import 'package:today_news/routes/routes.dart';
import 'package:today_news/screen/splash_screen/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper().init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TopheadlineProvider()),
        ChangeNotifierProvider(create: (_) => CategoryNewsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Today News',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashScreen(),
        onGenerateRoute: (settings) => Routes.generateRoutes(settings),
      ),
    );
  }
}
