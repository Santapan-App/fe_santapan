import 'package:flutter/material.dart';
import 'package:santapan_fe/core/color_styles.dart';
import 'package:santapan_fe/pages/splash_page.dart';

void main() {
  runApp(const Santapan());
}

class Santapan extends StatelessWidget {
  const Santapan({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    navigatorKey = Santapan.navigatorKey;
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: ColorStyles.bgScreen,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
