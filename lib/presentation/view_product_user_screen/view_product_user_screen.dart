import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:form_structure/widgets/custom_search_view.dart';
import 'package:http/http.dart' as http;
import 'package:form_structure/widgets/custom_text_form_field.dart';

class ViewPageUserScreen extends StatelessWidget {
  ViewPageUserScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

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
                                imagePath: ImageConstant.imgJagokisanremovebgpreview,
                                height: 97.v,
                                width: 104.h,
                                radius: BorderRadius.circular(48.h),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageView(
                              svgPath: ImageConstant.imgVolume,
                              height: 35.v,
                              width: 40.h,
                              margin: EdgeInsets.only(
                                top: 10.v,
                                bottom: 7.v,
                              ),
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 27.h,
                                  right: 27.h,
                                  top: 10.v,
                                ),
                                child: Text(
                                  "Products",
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomSearchView(
                        margin: EdgeInsets.only(
                          left: 40.h,
                          top: 15.v,
                          right: 33.h,
                          bottom: 15.h
                        ),
                        controller: searchController,
                        hintText: "Search here",
                        hintStyle: CustomTextStyles.titleBlack,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(14.h, 10.v, 5.h, 10.v),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgSearch,
                            color: Colors.black,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 41.v,
                        ),
                        suffix: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 8.v, 15.h, 8.v),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgClose,
                            color: Colors.black,
                          ),
                        ),
                        suffixConstraints: BoxConstraints(
                          maxHeight: 41.v,
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.fromLTRB(30.h, 8.v, 30.h, 8.v) ,
                   
                        child: Column(
                          children: [
                            SizedBox(height: 5.v),
                            Container(
                              height: 250,
                              padding: EdgeInsets.symmetric(
                                horizontal: 17.h,
                                vertical: 14.v,
                              ),
                              decoration: AppDecoration.outlineGray.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder18,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Opacity(
                                    opacity: 0.9,
                                    child: CustomImageView(
                                      imagePath: ImageConstant.imgBillmiller1,
                                      height: 143.v,
                                      width: 134.h,
                                      radius: BorderRadius.circular(67.h),
                                      margin: EdgeInsets.only(
                                        left: 2.h,
                                        top: 35.v,
                                        bottom: 17.v,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.v),
                                    child: Column(
                                      children: [
                                        Opacity(
                                          opacity: 0.9,
                                          child: Text(
                                            "Farmer : Sajeevan Siva",
                                            style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold, // Make text bold
                        fontSize: 15.0, // Increase font size
                      ),
                                          ),
                                        ),
                                        SizedBox(height: 12.v),
                                        Opacity(
                                          opacity: 0.9,
                                          child: Text(
                                            "Potato",
                                            style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold, // Make text bold
                        fontSize: 15.0, // Increase font size
                      ),
                                          ),
                                        ),
                                        SizedBox(height: 5.v),
                                        Opacity(
                                          opacity: 0.9,
                                          
                                          child: SizedBox(
                                            width: 89.h,
                                            
                                            child: Text(
                                              "15 kg\nPrice per kg:-",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold, // Make text bold
                        fontSize: 15.0, 
                        // Increase font size
                      ),
                                            ),
                                          ),
                                        ),
                                        Opacity(
                                          opacity: 0.9,
                                          child: SizedBox(
                                            width: 89.h,
                                            child: Text(
                                              "100",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold, // Make text bold
                        fontSize: 15.0, // Increase font size
                      ),
                                            ),
                                          ),
                                        ),
                                        Opacity(
                                          opacity: 0.9,
                                          child: SizedBox(
                                            width: 89.h,
                                            child: Text(
                                              "Expiry date:-",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold, // Make text bold
                        fontSize: 15.0, // Increase font size
                      ),
                                            ),
                                          ),
                                        ),
                                        Opacity(
                                          opacity: 0.9,
                                          child: SizedBox(
                                            width: 89.h,
                                            child: Text(
                                              "20/10/2023",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold, // Make text bold
                        fontSize: 15.0, // Increase font size
                      ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 10.h,
                                              top: 6.v,
                                            ),
                                            child: Row(
                                              children: [
                                                CustomElevatedButton(
                                                  width: 68.h,
                                                  text: "Bid",
                                                  margin: EdgeInsets.only(top: 14.v),
                                                ),
                                                Opacity(
                                                  opacity: 0.9,
                                                  child: CustomImageView(
                                                    svgPath: ImageConstant.imgUser,
                                                    height: 34.adaptSize,
                                                    width: 34.adaptSize,
                                                    margin: EdgeInsets.only(left: 20.h,top: 14.v),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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

