import 'package:flutter/material.dart';
import 'package:kilo/models/prod.dart';
import 'package:kilo/pages/launch_screen.dart';
import 'package:kilo/pages/login/input_new_pass.dart';
import 'package:kilo/pages/login/restore_pass_page.dart';
import 'package:kilo/pages/login/sign_in_page.dart';
import 'package:kilo/pages/login/verification_page.dart';
import 'package:kilo/pages/product/product_page.dart';
import 'package:kilo/pages/product/product_pocket.dart';
import 'package:kilo/pages/product/seller_page.dart';
import 'package:kilo/pages/profile/buy_seting.dart';
import 'package:kilo/pages/profile/profile.dart';

import 'pages/home_page.dart';
import 'pages/login/sign_up_page.dart';
import 'pages/main_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(
          builder: (context) => HomePage(), settings: settings);
    case Routes.signIn:
      return MaterialPageRoute(
          builder: (context) => SignInPage(), settings: settings);
    case Routes.signUp:
      return MaterialPageRoute(
          builder: (context) => SignUpPage(), settings: settings);
    case Routes.verify:
      return MaterialPageRoute(
          builder: (context) => VerifyPage(), settings: settings);
    case Routes.inputPass:
      return MaterialPageRoute(
          builder: (context) => NewPassPage(
                email: '',
              ),
          settings: settings);
    case Routes.launchScreen:
      return MaterialPageRoute(
          builder: (context) => LaunchMainPage(), settings: settings);
    case Routes.restorePass:
      return MaterialPageRoute(
          builder: (context) => RestorePage(), settings: settings);
    // case Routes.inputPass:
    //   return MaterialPageRoute(
    //       builder: (context) => NewPassPage(), settings: settings);
    case Routes.main:
      return MaterialPageRoute(
          builder: (context) => MainPage(
                token: settings.arguments as bool,
              ),
          settings: settings);
    case Routes.productPage:
      return MaterialPageRoute(
          builder: (context) => ProductPage(
                login: settings.arguments as bool,
              ),
          settings: settings);
    case Routes.pocet:
      return MaterialPageRoute(
          builder: (context) => Pocet(
                prod: (settings.arguments as Map)['prod'] as Prod,
                number: (settings.arguments as Map)['number'] as num,
              ),
          settings: settings);
    case Routes.profile:
      return MaterialPageRoute(
          builder: (context) => Profile(), settings: settings);
    case Routes.setting:
      return MaterialPageRoute(
          builder: (context) => Setting(), settings: settings);
    case Routes.seller:
      return MaterialPageRoute(
          builder: (context) => SellerPage(), settings: settings);
    default:
      return MaterialPageRoute(
          builder: (context) => MainPage(
                token: settings.arguments as bool,
              ),
          settings: settings);
  }
}

class Routes {
  static const home = '/';
  static const seller = '/seller';
  static const setting = '/setting';
  static const pocet = '/pocet';
  static const profile = '/profile';
  static const productPage = '/productPage';
  static const launchScreen = '/launch';
  static const signIn = '/sigIn';
  static const signUp = '/sigUp';
  static const checkLocation = '/checkLocation';
  static const verify = '/verify';
  static const restorePass = '/restore';
  static const inputPass = '/inputNewPass';
  static const main = '/main';
}
