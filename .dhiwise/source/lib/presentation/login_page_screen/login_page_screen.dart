import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:form_structure/widgets/custom_text_form_field.dart';

class LoginPageScreen extends StatelessWidget {
  LoginPageScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
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
                          imagePath: ImageConstant.imgJagokisanremovebgpreview,
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
                            "Login Your Account",
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
                Container(
                  margin: EdgeInsets.only(
                    left: 24.h,
                    top: 46.v,
                    right: 24.h,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.h,
                    vertical: 11.v,
                  ),
                  decoration: AppDecoration.outlineGreen.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder26,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Opacity(
                        opacity: 0.9,
                        child: CustomImageView(
                          svgPath: ImageConstant.imgCalculator,
                          height: 22.v,
                          width: 25.h,
                          margin: EdgeInsets.only(
                            top: 5.v,
                            bottom: 3.v,
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.9,
                        child: Padding(
                          padding: EdgeInsets.only(left: 17.h),
                          child: Text(
                            "Email Address",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomElevatedButton(
                  text: "LOGIN",
                  margin: EdgeInsets.fromLTRB(37.h, 79.v, 23.h, 5.v),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(
          onChanged: (BottomBarEnum type) {},
        ),
      ),
    );
  }
}
