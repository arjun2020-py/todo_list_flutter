// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:todo/HomePage/view/home_page.dart';
import 'package:todo/Login/view/login_page.dart';
import 'package:todo/Profile/view/profile_page.dart';
import 'package:todo/Siginup/view/siginup_page.dart';
import 'package:todo/l10n/l10n.dart';
import 'package:todo/splash/view/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashScreen(),
      routes: {
        'Login': (context) => LoginPage(),
        // 'Siginup':(context) => SiginupPage(),
        'Home': (context) => HomePage(),
        'Siginup': (context) => SiginupPage(),
        'profile': (context) => ProfileScreen()
      },
    );
  }
}
