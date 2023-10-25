import 'package:flutter/material.dart';
import 'package:form_structure/presentation/register_page_screen.dart';
import 'package:form_structure/presentation/user_login_page_screen.dart';
import 'package:form_structure/presentation/forgot_password_screen.dart';
import 'package:form_structure/presentation/bank_account_details_screen.dart';
import 'package:form_structure/presentation/profile_update_screen.dart';

class AppRoutes {
  static const String loginPageScreen = '/login_page_screen';
  static const String homePageScreen = '/home_page_screen';
  static const String registerPageScreen = '/register_page_screen';
  static const String userLoginPageScreen = '/user_login_page_screen';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String banAccountDetailsScreen =
      '/bank_account_details_screen.dart';
  static const String userProfileScreen = '/profile_update_screen';

  static Map<String, WidgetBuilder> routes = {
    registerPageScreen: (context) => RegisterPageScreen(),
    userLoginPageScreen: (context) => UserLoginPageScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordPage(),
    banAccountDetailsScreen: (context) => BankAccountPageScreen(),
    userProfileScreen: (context) => UserProfilePage()
  };
}
