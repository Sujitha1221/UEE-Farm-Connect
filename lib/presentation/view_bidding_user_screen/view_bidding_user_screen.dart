import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:form_structure/widgets/custom_search_view.dart';
import 'package:http/http.dart' as http;
import 'package:form_structure/widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';

class ViewBiddingPage extends StatefulWidget {
  ViewBiddingPage({Key? key}) : super(key: key);

  @override
  _VBPScreenState createState() => _VBPScreenState();
}

class _VBPScreenState extends State<ViewBiddingPage> {
  List<Map<String, dynamic>> biddingList = [];
  late http.Client client;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    fetchUserBiddingHistory();
  }

  Future<void> fetchUserBiddingHistory() async {
    final List<Map<String, dynamic>>? fetchedBiddingList =
        await getAllBidding(context);
    if (fetchedBiddingList != null) {
      setState(() {
        biddingList = fetchedBiddingList;
      });
    }
  }

  Future<List<Map<String, dynamic>>?> getAllBidding(
      BuildContext context) async {
    try {
      final userName = "adsFrom";
      final response = await client.get(
        Uri.parse('http://192.168.1.6:8080/bidding/get-history-user/$userName'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.body != null) {
        final List<Map<String, dynamic>> biddingList =
            (json.decode(response.body) as List)
                .map((item) => item as Map<String, dynamic>)
                .toList();
        print(biddingList);
        return biddingList;
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch purchase requisitions');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

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
                                imagePath:
                                    ImageConstant.imgJagokisanremovebgpreview,
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
                              onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                  '/view_current_bidding_screen');
                            },
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
                                  "Bidding History",
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomSearchView(
                        margin: EdgeInsets.only(
                            left: 40.h, top: 15.v, right: 33.h, bottom: 15.h),
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
                      ListView.builder(
                          itemCount: biddingList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> bid = biddingList[index];
                            String farmerUserName =
                                bid['farmerUserName'] ?? "Unknown";
                            String weight = bid['weight'] ?? "Unknown";
                            String totalAmount = bid['totalAmount'] ?? "0.0";
                            double ppkg = (int.parse(bid['weight']) /
                                int.parse(bid['totalAmount']));
                            String status = bid['status'] ?? "Null";
                            return Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.fromLTRB(30.h, 8.v, 30.h, 8.v),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5.v),
                                  Container(
                                    height: 150,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.h,
                                      vertical: 10.v,
                                    ),
                                    decoration:
                                        AppDecoration.outlineGray.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder18,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 2.v),
                                          child: Column(
                                            children: [
                                              Opacity(
                                                opacity: 0.9,
                                                child: Text(
                                                  "$farmerUserName",
                                                  style: theme
                                                      .textTheme.labelLarge
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 12.v),
                                              Opacity(
                                                opacity: 0.9,
                                                child: Text(
                                                  "Price Per Kg : " + "$ppkg",
                                                  style: theme
                                                      .textTheme.labelLarge
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                    color: Color(0xFF0A5C03),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 12.v),
                                              Opacity(
                                                opacity: 0.9,
                                                child: Text(
                                                  "TotalKg : " + "$weight",
                                                  style: theme
                                                      .textTheme.labelLarge
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                    color: Color(0xFF0A5C03),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5.v),
                                              Opacity(
                                                opacity: 0.9,
                                                child: Text(
                                                  "Total : " + "$totalAmount",
                                                  style: theme
                                                      .textTheme.labelLarge
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                    color: Color(0xFF0A5C03),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 10.h,
                                                  top: 6.v,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 130.h,
                                          height:
                                              30.v, // Set the desired height
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 44.v),
                                          child: Opacity(
                                            opacity: 0.9,
                                            child: Text(
                                              "${status.toUpperCase()}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: theme.textTheme.labelLarge
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0,
                                                color: getColorForStatus(status), 
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
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
  Color getColorForStatus(String status) {
    switch (status) {
      case "expired":
        return Color.fromARGB(255, 3, 51, 92); 
      case "Accepted":
        return Color(0xFF0A5C03); 
      case "rejected":
        return Colors.red;
      default:
        return Colors.black;  
    }
  }
}
