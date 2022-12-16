import 'package:e_commers/ui/Views/Home/home_page.dart';
import 'package:e_commers/ui/Views/Profile/profile_page.dart';
import 'package:e_commers/ui/Views/Profile/shopping/shopping_page.dart';
import 'package:e_commers/ui/Views/cart/cart_page.dart';
import 'package:e_commers/ui/Views/favorite/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/ui/Views/Login/login_page.dart';
import 'package:e_commers/ui/Views/Login/loading_page.dart';
import 'package:e_commers/ui/Views/Login/register_page.dart';
import 'package:e_commers/ui/Views/Start/start_home_page.dart';

Map<String, Widget Function(BuildContext context)> routes = {
  'loadingPage': (context) => LoadingPage(),
  'getStarted': (context) => StartHomePage(),
  'signInPage': (context) => SignInPage(),
  'signUpPage': (context) => SignUpPage(),
  'homePage': (context) => HomePage(),
  'cartPage': (context) => CartPage(),
  'favoritePage': (context) => FavoritePage(),
  'profilePage': (context) => ProfilePage(),
  'shoppingPage': (context) => ShoppingPage(),
};
