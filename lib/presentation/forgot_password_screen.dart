import 'dart:convert';
import 'package:flutter/material.dart'; // Import material.dart
import 'package:http/http.dart' as http;
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:form_structure/widgets/custom_text_form_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> changePassword(BuildContext context) async {
    try {
      final email = emailController.text;
      final newPassword = newPasswordController.text;

      if (email.isNotEmpty && newPassword.isNotEmpty) {
        final response = await http.post(
          Uri.parse(
              'http://172.28.14.76:8080/user/change-pwd'), // Use the correct URL
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'newPassword': newPassword,
          }),
        );

        if (response.statusCode == 200) {
          // Show success dialog
          showSuccessDialog(context, "Password changed successfully");
        } else {
          // Show error dialog
          showErrorDialog(context, "Password change failed");
        }
      } else {
        // Show error dialog for missing fields
        showErrorDialog(context, "Please fill in all fields");
      }
    } catch (e) {
      // Handle network errors or other exceptions and show an error dialog
      showErrorDialog(context, "An error occurred: $e");
    }
  }

  void showSuccessDialog(BuildContext context, String message) {
    final scaffoldContext = _scaffoldKey.currentContext;
    if (scaffoldContext != null) {
      showDialog(
        context: scaffoldContext,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.userLoginPageScreen);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void showErrorDialog(BuildContext context, String errorMessage) {
    final scaffoldContext = _scaffoldKey.currentContext;
    if (scaffoldContext != null) {
      showDialog(
        context: scaffoldContext,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
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
              Image.asset('./././assets/images/forgotPassword.png'),
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
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                child: SizedBox(
                  width: double.maxFinite,
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
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    '/user_login_page_screen');
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
                                  left: 27.h,
                                  top: 10.v,
                                ),
                                child: Text(
                                  "Forgot Password",
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
                        controller: emailController,
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 52.v,
                          right: 25.h,
                        ),
                        hintText: "Email Address",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27.h, 15.v, 17.h, 15.v),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgCalculator,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 54.v,
                        ),
                      ),
                      CustomTextFormField(
                        controller: newPasswordController,
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 52.v,
                          right: 25.h,
                        ),
                        hintText: "Enter new password",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27.h, 15.v, 17.h, 15.v),
                          child: CustomImageView(
                            imagePath: ImageConstant.password,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 54.v,
                        ),
                      ),
                      CustomElevatedButton(
                        text: "Change Password",
                        margin: EdgeInsets.fromLTRB(37.h, 79.v, 23.h, 5.v),
                        onTap: () {
                          changePassword(context);
                        },
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
