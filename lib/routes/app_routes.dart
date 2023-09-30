import 'package:flutter/material.dart';
import 'package:form_structure/presentation/home_page_screen/home_page_screen.dart';
import 'package:form_structure/presentation/login_page_screen/login_page_screen.dart';


class AppRoutes {
  static const String loginPageScreen = '/login_page_screen';
  static const String homePageScreen = '/home_page_screen';

  static Map<String, WidgetBuilder> routes = {
    loginPageScreen: (context) => LoginPageScreen(),
    homePageScreen: (context) => HomePageScreen()
  };

  
}
