import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  final Widget nextScreen;
  const SplashScreen({
    super.key,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: backgroundColour,
      splashIconSize: 250,
      duration: 1500,
      splash: Image.asset(
        "assets/images/logo2.png",
        fit: BoxFit.contain,
      ),
      nextScreen: nextScreen,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}
