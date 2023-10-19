import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
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
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      usernameController.text = prefs.getString('userName') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      roleController.text = prefs.getString('role') ?? '';
      contactController.text = prefs.getString('contact') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    });
  }

  Future<void> updateUserProfile() async {
    final newUsername = usernameController.text;
    final newEmail = emailController.text;
    final newRole = roleController.text;
    final newContact = contactController.text;
    final newPassword = passwordController.text;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', newUsername);
    prefs.setString('email', newEmail);
    prefs.setString('role', newRole);
    prefs.setString('contact', newContact);
    prefs.setString('password', newPassword);

    try {
      final response = await http.put(
        Uri.parse(
            'YOUR_UPDATE_PROFILE_API_ENDPOINT'), // Replace with your API endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': newUsername,
          'email': newEmail,
          'role': newRole,
          'contact': newContact,
          'password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        // Show a success dialog
        showSuccessDialog('Profile updated successfully');
      } else {
        // Show an error dialog
        showErrorDialog('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or other exceptions and show an error dialog
      showErrorDialog('An error occurred: $e');
    }
  }

  Future<void> deleteUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear(); // Clear all user data from shared preferences

    try {
      final response = await http.delete(
        Uri.parse('YOUR_UPDATE_PROFILE_API_ENDPOINT'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text, // Pass the user's email as a parameter
        }),
      );

      if (response.statusCode == 200) {
        // Show a success dialog
        showSuccessDialog('Profile deleted successfully');
        // After successful deletion, navigate to a different screen, e.g., the login screen.
        Navigator.of(context).pushReplacementNamed(AppRoutes.loginPageScreen);
      } else {
        // Show an error dialog
        showErrorDialog('Failed to delete profile: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or other exceptions and show an error dialog
      showErrorDialog('An error occurred: $e');
    }
  }

  void showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
        ),
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
                              height: 28.v,
                              width: 35.h,
                              margin: EdgeInsets.only(
                                top: 13.v,
                                bottom: 7.v,
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
                                  "Create Account",
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgUnverifiedaccount,
                              height: 46.v,
                              width: 52.h,
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
                            svgPath: ImageConstant.imgCalculator,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(maxHeight: 54),
                      ),
                      CustomTextFormField(
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
                      CustomTextFormField(
                        controller: roleController,
                        margin: EdgeInsets.fromLTRB(25, 15, 25, 0),
                        hintText: 'Role',
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27, 15, 17, 15),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgCalculator,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(maxHeight: 54),
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
                            svgPath: ImageConstant.imgCalculator,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(maxHeight: 54),
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        margin: EdgeInsets.fromLTRB(25, 15, 25, 0),
                        hintText: 'Password',
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27, 15, 17, 15),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgCalculator,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(maxHeight: 54),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: updateUserProfile,
                        child: Text('Update Profile'),
                      ),
                      ElevatedButton(
                        onPressed: deleteUserProfile,
                        child: Text('Delete Profile'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
