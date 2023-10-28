import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:form_structure/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName');
    final email = prefs.getString('email');
    final role = prefs.getString('role');
    final contact = prefs.getString('contact');

    // Set the text in the controllers inside a setState to trigger a rebuild
    setState(() {
      usernameController.text = userName ?? '';
      emailController.text = email ?? '';
      roleController.text = role ?? '';
      contactController.text = contact ?? '';
    });
  }

  Future<void> updateUserProfile() async {
    try {
      final url = 'http://172.28.14.76:8080/user/update-user';
      final response = await http.put(
        Uri.parse(url),
        body: {
          'email': emailController.text,
          'username': usernameController.text,
          'contact': contactController.text,
        },
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Success"),
            content: Text("Profile updated successfully"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pushReplacementNamed(
                      AppRoutes.userLoginPageScreen); // Navigate to login page
                },
              ),
            ],
          ),
        );
      } else {
        throw Exception("Failed to update profile");
      }
    } catch (error) {
      _showErrorDialog("Error updating profile");
    }
  }

  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  Future<void> deleteUserProfile() async {
    try {
      final url =
          'http://172.28.14.76:8080/user/delete-user/${emailController.text}';

      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Success"),
            content: Text("Profile deleted successfully"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pushReplacementNamed(AppRoutes
                      .registerPageScreen); // Navigate to registration page
                },
              ),
            ],
          ),
        );
      } else {
        print("Error response: ${response.body}"); // Add this line
        throw Exception("Failed to delete profile");
      }
    } catch (error) {
      _showErrorDialog("Error deleting profile");
      print(error);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Image.asset('./././assets/images/profile.png'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 144.v,
                        width: double.maxFinite,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse1,
                                height: 82.v,
                                width: 131.h,
                                alignment: Alignment.topLeft,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse2,
                                height: 53.v,
                                width: 200.h,
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 25.h),
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse3,
                                height: 96.v,
                                width: 118.h,
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse4,
                                height: 73.v,
                                width: 178.h,
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath:
                                    ImageConstant.imgJagokisanremovebgpreview,
                                height: 97.v,
                                width: 104.h,
                                radius: BorderRadius.circular(
                                  48.h,
                                ),
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 17.h,
                          top: 15.v,
                          right: 7.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomImageView(
                              svgPath: ImageConstant.imgVolume,
                              onTap: () async {
                                String? userRole = await getUserRole();
                                if (userRole == 'farmer') {
                                  // Navigate to the farmer dashboard page
                                  Navigator.of(context).pushReplacementNamed(
                                      '/farmer_dashboard_scree');
                                } else if (userRole == 'buyer') {
                                  // Navigate to the buyer dashboard page
                                  Navigator.of(context).pushReplacementNamed(
                                      '/buyer_dashboard_screen');
                                } else {
                                  // Handle the case where the userRole is not 'farmer' or 'buyer', if needed
                                  print("Unknown user role");
                                }
                              },
                              height: 28,
                              width: 35,
                              margin: EdgeInsets.only(
                                top: 13,
                                bottom: 7,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 27.h,
                                  top: 10.v,
                                ),
                                child: Text(
                                  "Your Profile",
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgUnverifiedaccount,
                              height: 46.v,
                              width: 52.h,
                              onTap: () => _showAlertDialog(context),
                              margin: EdgeInsets.only(
                                left: 2.h,
                                bottom: 2.v,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextFormField(
                        controller: usernameController,
                        margin: EdgeInsets.fromLTRB(25, 52, 25, 0),
                        hintText: 'Username',
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27, 15, 17, 15),
                          child: CustomImageView(
                            imagePath: ImageConstant.account,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(maxHeight: 54),
                      ),
                      IgnorePointer(
                        ignoring: true,
                        child: CustomTextFormField(
                          controller: emailController,
                          margin: EdgeInsets.fromLTRB(25, 15, 25, 0),
                          hintText: 'Email',
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                          prefix: Container(
                            margin: EdgeInsets.fromLTRB(27, 15, 17, 15),
                            child: CustomImageView(
                              svgPath: ImageConstant.imgCalculator,
                            ),
                          ),
                          prefixConstraints: BoxConstraints(maxHeight: 54),
                        ),
                      ),
                      IgnorePointer(
                        child: CustomTextFormField(
                          controller: roleController,
                          margin: EdgeInsets.fromLTRB(25, 15, 25, 0),
                          hintText: 'Role',
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                          prefix: Container(
                            margin: EdgeInsets.fromLTRB(27, 15, 17, 15),
                            child: CustomImageView(
                              imagePath: ImageConstant.role,
                            ),
                          ),
                          prefixConstraints: BoxConstraints(maxHeight: 54),
                        ),
                      ),
                      CustomTextFormField(
                        controller: contactController,
                        margin: EdgeInsets.fromLTRB(25, 15, 25, 0),
                        hintText: 'Contact',
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.phone,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27, 15, 17, 15),
                          child: CustomImageView(
                            imagePath: ImageConstant.contact,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(maxHeight: 54),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              onTap: updateUserProfile,
                              margin: EdgeInsets.fromLTRB(37, 79, 23, 5),
                              text: "Update Profile",
                            ),
                          ),
                          SizedBox(
                              width:
                                  10), // to give a small gap between the two buttons
                          Expanded(
                            child: CustomElevatedButton(
                              onTap: deleteUserProfile,
                              margin: EdgeInsets.fromLTRB(37, 79, 23, 5),
                              text: "Delete Profile",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomBar(
          onChanged: (BottomBarEnum type) {},
        ),
      ),
    );
  }
}
