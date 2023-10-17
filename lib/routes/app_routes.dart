import 'package:flutter/material.dart';
import 'package:form_structure/presentation/add_product_page_screen/add_product_page_screen.dart';
import 'package:form_structure/presentation/home_page_screen/home_page_screen.dart';
import 'package:form_structure/presentation/login_page_screen/login_page_screen.dart';
import 'package:form_structure/presentation/request_bidding_page_screen/request_bidding_page_screen.dart';
import 'package:form_structure/presentation/view_current_bidding_user_screen/view_current_bidding_user_screen.dart';
import 'package:form_structure/presentation/view_product_user_screen/view_product_user_screen.dart';

import '../presentation/payment_farmer_screen/payment_farmer_screen.dart';
import '../presentation/payment_user_screen/payment_user_screen.dart';
import '../presentation/view_bidding_farmer_screen/view_bidding_farmer_screen.dart';
import '../presentation/view_bidding_user_screen/view_bidding_user_screen.dart';
import '../presentation/view_current_bidding_farmer_screen/view_current_bidding_farmer_screen.dart';




class AppRoutes {
  static const String loginPageScreen = '/login_page_screen';
  static const String homePageScreen = '/home_page_screen';
  static const String addProductPageScreen = '/add_product_page_screen';
  static const String viewProductPageUserScreen = '/view_product_page_user_screen';
  static const String RequestBiddingScreen = '/request_bidding_screen';
  static const String ViewCurrentBiddingFarmerScreen = '/view_current_bidding_farmer_screen';
  static const String ViewBiddingFarmerScreen = '/view_bidding_farmer_screen';
  static const String ViewCurrentBiddingScreen = '/view_current_bidding_screen';
  static const String ViewBiddingScreen = '/view_bidding_screen';
  static const String PaymentUserScreens = '/payment_user_screen';
  static const String PaymentFarmerScreens = '/payment_farmer_screen';
  

  static Map<String, WidgetBuilder> routes = {
    loginPageScreen: (context) => LoginPageScreen(),
    homePageScreen: (context) => HomePageScreen(),
    addProductPageScreen:(context) => AddProductPageScreen(),
    viewProductPageUserScreen:(context) => RequestBiddingPage(),
    RequestBiddingScreen:(context) =>RequestBiddingPage(),
    ViewCurrentBiddingFarmerScreen:(context) => ViewCurrentBiddingFarmerPage(),
    ViewBiddingFarmerScreen: (context) => ViewBiddingFarmerPage(),
    ViewCurrentBiddingScreen:(context) => ViewCurrentBiddingPage(),
    ViewBiddingScreen: (context) => ViewBiddingPage(),
    PaymentUserScreens:(context) => PaymentUserScreen(),
    PaymentFarmerScreens: (context) => PaymentFarmerScreen()
  };

  
}
