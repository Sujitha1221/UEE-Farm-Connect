import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHome,
      activeIcon: ImageConstant.imgHome,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgUser,
      activeIcon: ImageConstant.imgUser,
      type: BottomBarEnum.User,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgArrowright,
      activeIcon: ImageConstant.imgArrowright,
      type: BottomBarEnum.Arrowright,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41.v,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.2),
        border: Border.all(
          color: appTheme.gray800,
          width: 1.h,
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Opacity(
              opacity: 0.9,
              child: CustomImageView(
                svgPath: bottomMenuList[index].icon,
                height: 34.adaptSize,
                width: 34.adaptSize,
                color: appTheme.green90001,
              ),
            ),
            activeIcon: Opacity(
              opacity: 0.9,
              child: CustomImageView(
                svgPath: bottomMenuList[index].activeIcon,
                height: 34.v,
                width: 37.h,
                color: theme.colorScheme.onSecondary,
              ),
            ),
            label: '',
          );
        }),
        onTap: (index) {
          handleNavigation(bottomMenuList[index].type);
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  void handleNavigation(BottomBarEnum type) async {
    String? userRole = await getUserRole();
    switch (type) {
      case BottomBarEnum.Home:
        if (userRole == 'farmer') {
          // Navigate to the farmer dashboard page
          Navigator.of(context).pushReplacementNamed('/farmer_dashboard_scree');
        } else if (userRole == 'buyer') {
          // Navigate to the buyer dashboard page
          Navigator.of(context).pushReplacementNamed('/buyer_dashboard_screen');
        }
        break;
      case BottomBarEnum.User:
        // Handle User button action
        Navigator.of(context).pushReplacementNamed('/profile_update_screen');
        break;
      case BottomBarEnum.Arrowright:
        // Handle Arrowright button action
        Navigator.of(context).pushReplacementNamed('/user_login_page_screen');
        break;
    }
    widget.onChanged?.call(type);
  }
}

enum BottomBarEnum {
  Home,
  User,
  Arrowright,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}
