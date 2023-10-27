import 'package:flutter/material.dart';
import 'package:form_structure/presentation/register_page_screen.dart';
import 'package:form_structure/presentation/user_login_page_screen.dart';
import 'package:form_structure/presentation/forgot_password_screen.dart';
import 'package:form_structure/presentation/bank_account_details_screen.dart';
import 'package:form_structure/presentation/profile_update_screen.dart';
import 'package:form_structure/presentation/buyer_dashboard_screen.dart';
import 'package:form_structure/presentation/farmer_dashboard_scree.dart';

class AppRoutes {
  static const String registerPageScreen = '/register_page_screen';
  static const String userLoginPageScreen = '/user_login_page_screen';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String banAccountDetailsScreen =
      '/bank_account_details_screen.dart';
  static const String userProfileScreen = '/profile_update_screen';
  static const String buyerDashboardScreen = '/buyer_dashboard_screen';
  static const String farmerDashboardScreen = 'farmer_dashboard_scree';

  static Map<String, WidgetBuilder> routes = {
    registerPageScreen: (context) => RegisterPageScreen(),
    userLoginPageScreen: (context) => UserLoginPageScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordPage(),
    banAccountDetailsScreen: (context) => BankAccountPageScreen(),
    userProfileScreen: (context) => UserProfilePage(),
    buyerDashboardScreen: (context) => DashboardScreen(),
    farmerDashboardScreen: (context) => FarmerDashboardScreen()
  };
}
