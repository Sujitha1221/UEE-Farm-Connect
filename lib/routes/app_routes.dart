
import 'package:flutter/material.dart';
import 'package:form_structure/presentation/add_product_page_screen/add_product_page_screen.dart';
import 'package:form_structure/presentation/home_page_screen/home_page_screen.dart';
import 'package:form_structure/presentation/login_page_screen/login_page_screen.dart';
import 'package:form_structure/presentation/view_product_user_screen/view_product_user_screen.dart';
import 'package:form_structure/presentation/view_product_farmer_screen/view_product_farmer_screen.dart';




class AppRoutes {
  static const String loginPageScreen = '/login_page_screen';
  static const String homePageScreen = '/home_page_screen';
  static const String addProductPageScreen = '/add_product_page_screen';
  static const String viewProductPageUserScreen = '/view_product_page_user_screen';
  static const String viewProductPageFarmerScreen = '/view_product_page_farmer_screen';


  

  static Map<String, WidgetBuilder> routes = {
    loginPageScreen: (context) => LoginPageScreen(),
    homePageScreen: (context) => HomePageScreen(),
    addProductPageScreen:(context) => AddProductPageScreen(),
    viewProductPageUserScreen:(context) => ViewPageUserScreen(),
    viewProductPageFarmerScreen:(context)=>ViewPageFarmerScreen()
    
  };

  
}
