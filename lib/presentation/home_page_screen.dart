import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:form_structure/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                    Image.asset(
                      './././assets/images/farming.png',
                      height: 380,
                      width: 380,
                    ),
                    Text(
                      "Agriculture: where hard work and nature's magic come together.",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    CustomElevatedButton(
                      text: 'Get Started',
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/user_login_page_screen');
                      },
                      // Add properties below to adjust the button size
                      margin: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical:
                              20), // Adjust horizontal and vertical padding to make the button larger
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
