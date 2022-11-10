import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/Login/view/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(

      backgroundColor: const Color(0xff0097a7),
     splash:Lottie.asset('assets/images/107385-login.json') ,
     nextScreen: LoginPage(),
     splashIconSize: 250,
     duration: 5000,
     splashTransition: SplashTransition.fadeTransition,
      
    );
  }
}
