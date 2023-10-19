import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:form_structure/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';

class UserLoginPageScreen extends StatefulWidget {
  @override
  _UserLoginPageScreenState createState() => _UserLoginPageScreenState();
}

class _UserLoginPageScreenState extends State<UserLoginPageScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> loginUser(BuildContext context) async {
    // Pass context to loginUser
    try {
      final email = emailController.text;
      final password = passwordController.text;
      if (email != null &&
          password != null &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        final response = await http.post(
          Uri.parse('http://192.168.1.12:8080/user/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
        );

        if (response.statusCode == 200) {
          final userData = jsonDecode(response.body);

          if (userData != null) {
            // Handle success and show the success dialog
            showSuccessDialog(context, userData);
            // ...
          } else {
            // Handle the case where userData is null and show an error dialog
            showErrorDialog(context, 'User data is null');
          }
        } else {
          // Handle login error and show an error dialog
          print('Login failed with status: ${response.statusCode}');
          print('Response body: ${response.body}');
          showErrorDialog(
              context, 'Login failed with status ${response.statusCode}');
        }
      } else {
        // Handle the case where email or password is null and show an error dialog
      }
    } catch (e) {
      // Handle network errors or other exceptions and show an error dialog
      print('Error: $e');
      showErrorDialog(context, 'An error occurred: $e');
    }
  }

  void showSuccessDialog(BuildContext context, Map<String, dynamic> userData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login Successful'),
          content: Text('You have successfully logged in.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (userData['role'] == 'farmer') {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.homePageScreen);
                } else if (userData['role'] == 'buyer') {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.registerPageScreen);
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text(errorMessage),
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

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userData['userName']);
    prefs.setString('email', userData['email']);
    prefs.setString('contact', userData['contact']);
    prefs.setString('role', userData['role']);
    prefs.setString('password', userData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: double
                      .infinity, // Use double.infinity instead of double.maxFinite
                  child: Column(
                    children: [
                      SizedBox(
                        height: 144, // Remove .v and .h
                        width: double
                            .infinity, // Use double.infinity instead of double.maxFinite
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse1,
                                height: 82, // Remove .v and .h
                                width: 131, // Remove .v and .h
                                alignment: Alignment.topLeft,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse2,
                                height: 53, // Remove .v and .h
                                width: 200, // Remove .v and .h
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 25),
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse3,
                                height: 96, // Remove .v and .h
                                width: 118, // Remove .v and .h
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse4,
                                height: 73, // Remove .v and .h
                                width: 178, // Remove .v and .h
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath:
                                    ImageConstant.imgJagokisanremovebgpreview,
                                height: 97, // Remove .v and .h
                                width: 104, // Remove .v and .h
                                radius: BorderRadius.circular(48), // Remove .h
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 17,
                          top: 15,
                          right: 7,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomImageView(
                              svgPath: ImageConstant.imgVolume,
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/home_page_screen');
                              },
                              height: 28, // Remove .v and .h
                              width: 35, // Remove .v and .h
                              margin: EdgeInsets.only(
                                top: 13,
                                bottom: 7,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 27,
                                  top: 10,
                                ),
                                child: Text(
                                  "Login Your Account",
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgUnverifiedaccount,
                              height: 46, // Remove .v and .h
                              width: 52, // Remove .v and .h
                              margin: EdgeInsets.only(
                                left: 2,
                                bottom: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        margin: EdgeInsets.only(
                          left: 25,
                          top: 52,
                          right: 25,
                        ),
                        hintText: "Email Address",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27, 15, 17, 15),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgCalculator,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 54,
                        ),
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        margin: EdgeInsets.only(
                          left: 25,
                          top: 52,
                          right: 25,
                        ),
                        hintText: "Password",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27, 15, 17, 15),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgCalculator,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 54,
                        ),
                      ),
                      CustomElevatedButton(
                        margin: EdgeInsets.fromLTRB(37, 79, 23, 5),
                        text: "Login",
                        onTap: () {
                          loginUser(context);
                        },
                      ),
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
