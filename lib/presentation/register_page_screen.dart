import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:http/http.dart' as http;

import 'package:form_structure/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class User {
  String userName;
  String email;
  int contact;
  String password;
  String role;

  User({
    required this.userName,
    required this.email,
    required this.contact,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'contact': contact,
      'password': password,
      'role': role,
    };
  }
}

class RegisterPageScreen extends StatefulWidget {
  RegisterPageScreen({Key? key}) : super(key: key);

  @override
  _RegisterPageScreenState createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  String selectedRole = "farmer";
  final List<String> roleOptions = ["farmer", "buyer"];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
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
                        controller: userNameController,
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 52.v,
                          right: 25.h,
                        ),
                        hintText: "Full name",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.name,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27.h, 15.v, 17.h, 15.v),
                          child: CustomImageView(
                            svgPath: ImageConstant.username,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 54.v,
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
                            svgPath: ImageConstant.email,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 54.v,
                        ),
                      ),
                      CustomTextFormField(
                        controller: contactController,
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 52.v,
                          right: 25.h,
                        ),
                        hintText: "Contact Number",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.phone,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27.h, 15.v, 17.h, 15.v),
                          child: CustomImageView(
                            svgPath: ImageConstant.phone,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 54.v,
                        ),
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 52.v,
                          right: 25.h,
                        ),
                        hintText: "Password",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27.h, 15.v, 17.h, 15.v),
                          child: CustomImageView(
                            svgPath: ImageConstant.password,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 54.v,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 25.0,
                          top: 52.0,
                          right: 25.0,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0), // Adjust padding as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust border radius as needed
                          border: Border.all(
                              color: Colors
                                  .black), // Adjust border color as needed
                        ),
                        child: DropdownButton<String>(
                          value: selectedRole,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedRole = newValue;
                              });
                            }
                          },
                          items: roleOptions.map((String role) {
                            return DropdownMenuItem<String>(
                              value: role,
                              child: Text(role),
                            );
                          }).toList(),
                        ),
                      ),
                      CustomElevatedButton(
                        text: "SUBMIT",
                        margin: EdgeInsets.fromLTRB(37.h, 79.v, 23.h, 5.v),
                        onTap: () {
                          int contact =
                              int.tryParse(contactController.text) ?? 0;
                          final user = User(
                            userName: userNameController.text,
                            email: emailController.text,
                            contact: contact,
                            password: passwordController.text,
                            role: selectedRole,
                          );

                          createUser(user);
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          print("Log in button pressed");
                          Navigator.of(context)
                              .pushNamed(AppRoutes.loginPageScreen);
                        },
                        child: Text("Already have an account? Log in"),
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

  Future<void> _showUserCreatedDialog(User user) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("User Created"),
          content: Text("Your account has been created successfully."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (user.role == "buyer") {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.banAccountDetailsScreen);
                } else if (user.role == "farmer") {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.userLoginPageScreen);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future createUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:8080/user/add-user'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        // Show a user-created dialog
        _showUserCreatedDialog(user);
      } else {
        // Handle error responses here
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to create user');
      }
    } catch (e) {
      // Handle network errors or other exceptions here
      print('Error: $e');
      throw Exception('Failed to create user1111111');
    }
  }
}
