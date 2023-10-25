import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:form_structure/widgets/custom_search_view.dart';
import 'package:form_structure/widgets/custom_text_form_field.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 144,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse1,
                                height: 82,
                                width: 131,
                                alignment: Alignment.topLeft,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse2,
                                height: 53,
                                width: 200,
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 25),
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse3,
                                height: 96,
                                width: 118,
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgEllipse4,
                                height: 73,
                                width: 178,
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: CustomImageView(
                                imagePath:
                                    ImageConstant.imgJagokisanremovebgpreview,
                                height: 97,
                                width: 104,
                                radius: BorderRadius.circular(48),
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 17, top: 15, right: 7),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomImageView(
                                  imagePath:
                                      ImageConstant.imgJagokisanremovebgpreview,
                                  height: 190,
                                  width: 150,
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 7.0),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/path');
                                  },
                                ),
                                CustomImageView(
                                  imagePath:
                                      ImageConstant.imgJagokisanremovebgpreview,
                                  height: 190,
                                  width: 150,
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 7.0),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomImageView(
                                  imagePath:
                                      ImageConstant.imgJagokisanremovebgpreview,
                                  height: 190,
                                  width: 150,
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 7.0),
                                ),
                                CustomImageView(
                                  imagePath:
                                      ImageConstant.imgJagokisanremovebgpreview,
                                  height: 190,
                                  width: 150,
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 7.0),
                                ),
                              ],
                            ),
                          ],
                        ),
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
