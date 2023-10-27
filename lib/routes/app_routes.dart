import 'package:flutter/material.dart';
import 'package:form_structure/presentation/add_product_page_screen/add_product_page_screen.dart';
import 'package:form_structure/presentation/request_bidding_page_screen/request_bidding_page_screen.dart';
import 'package:form_structure/presentation/view_current_bidding_user_screen/view_current_bidding_user_screen.dart';
import 'package:form_structure/presentation/view_product_user_screen/view_product_user_screen.dart';
import 'package:form_structure/presentation/view_product_farmer_screen/view_product_farmer_screen.dart';
import '../presentation/payment_farmer_screen/payment_farmer_screen.dart';
import '../presentation/payment_user_screen/payment_user_screen.dart';
import '../presentation/view_bidding_farmer_screen/view_bidding_farmer_screen.dart';
import '../presentation/view_bidding_user_screen/view_bidding_user_screen.dart';
import '../presentation/view_current_bidding_farmer_screen/view_current_bidding_farmer_screen.dart';
import '../presentation/user_login_page_screen.dart';
import '../presentation/register_page_screen.dart';
import '../presentation/forgot_password_screen.dart';
import '../presentation/bank_account_details_screen.dart';
import '../presentation/profile_update_screen.dart';
import 'package:form_structure/presentation/buyer_dashboard_screen.dart';
import 'package:form_structure/presentation/farmer_dashboard_scree.dart';



class AppRoutes {
  static const String loginPageScreen = '/login_page_screen';
  static const String homePageScreen = '/home_page_screen';
  static const String addProductPageScreen = '/add_product_page_screen';
  static const String viewProductPageUserScreen = '/view_product_page_user_screen';
  static const String viewProductPageFarmerScreen = '/view_product_page_farmer_screen';
  static const String RequestBiddingScreen = '/request_bidding_screen';
  static const String ViewCurrentBiddingFarmerScreen = '/view_current_bidding_farmer_screen';
  static const String ViewBiddingFarmerScreen = '/view_bidding_farmer_screen';
  static const String ViewCurrentBiddingScreen = '/view_current_bidding_screen';
  static const String ViewBiddingScreen = '/view_bidding_screen';
  static const String PaymentUserScreens = '/payment_user_screen';
  static const String PaymentFarmerScreens = '/payment_farmer_screen';
  static const String registerPageScreen = '/register_page_screen';
  static const String userLoginPageScreen = '/user_login_page_screen';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String banAccountDetailsScreen =
      '/bank_account_details_screen.dart';
  static const String userProfileScreen = '/profile_update_screen';
  static const String buyerDashboardScreen = '/buyer_dashboard_screen';
  static const String farmerDashboardScreen = '/farmer_dashboard_scree';

  


  

  static Map<String, WidgetBuilder> routes = {
    loginPageScreen: (context) => UserLoginPageScreen(),
    
    addProductPageScreen:(context) => AddProductPageScreen(),
    viewProductPageUserScreen:(context) => ViewPageUserScreen(),
    viewProductPageFarmerScreen:(context)=>ViewPageFarmerScreen(),
    RequestBiddingScreen:(context) =>RequestBiddingPage(productName: '',farmerName: ''),
    ViewCurrentBiddingFarmerScreen:(context) => ViewCurrentBiddingFarmerPage(),
    ViewBiddingFarmerScreen: (context) => ViewBiddingFarmerPage(),
    ViewCurrentBiddingScreen:(context) => ViewCurrentBiddingPage(),
    ViewBiddingScreen: (context) => ViewBiddingPage(),
    PaymentUserScreens:(context) => PaymentUserScreen(),
    PaymentFarmerScreens: (context) => PaymentFarmerScreen(),
    registerPageScreen: (context) => RegisterPageScreen(),
    userLoginPageScreen: (context) => UserLoginPageScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordPage(),
    banAccountDetailsScreen: (context) => BankAccountPageScreen(),
    userProfileScreen: (context) => UserProfilePage(),
    buyerDashboardScreen: (context) => DashboardScreen(),
    farmerDashboardScreen: (context) => FarmerDashboardScreen()

    
  };

  
}
