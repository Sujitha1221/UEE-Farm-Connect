import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:form_structure/widgets/custom_search_view.dart';
import 'package:http/http.dart' as http;
import 'package:form_structure/widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentUserScreen extends StatefulWidget {
  PaymentUserScreen({Key? key}) : super(key: key);

  @override
  _PUScreenState createState() => _PUScreenState();
}

class _PUScreenState extends State<PaymentUserScreen> {
  List<Map<String, dynamic>> paymentList = [];
  late http.Client client;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    fetchUserBiddingHistory();
  }

  Future<void> fetchUserBiddingHistory() async {
    final List<Map<String, dynamic>>? fetchedpaymentList =
        await getAllBidding(context);
    if (fetchedpaymentList != null) {
      setState(() {
        paymentList = fetchedpaymentList;
      });
    }
  }

  Future<List<Map<String, dynamic>>?> getAllBidding(
      BuildContext context) async {
    try {
      final userName = await getFarmerNameFromLocalStorage();
      print("user name: " + userName);
      final response = await client.get(
        Uri.parse(
            'http://192.168.56.1:8080/payment/get-all-payment-user/$userName'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.body != null) {
        final List<Map<String, dynamic>> paymentList =
            (json.decode(response.body) as List)
                .map((item) => item as Map<String, dynamic>)
                .toList();
        print(paymentList);
        return paymentList;
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
                              onTap: () => {
                                Navigator.of(context).pushReplacementNamed(
                                    '/view_current_bidding_farmer_screen')
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
                                  "Payment History",
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          itemCount: paymentList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> bid = paymentList[index];
                            String transactionDateTime =
                                bid['transactionDateTime'].substring(3, 16) ??
                                    "Unknown";
                            String amount = bid['amount'] ?? "0.0";

                            return Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.fromLTRB(30.h, 8.v, 30.h, 8.v),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5.v),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 0.h,
                                      vertical: 0.v,
                                    ),
                                    decoration:
                                        AppDecoration.outlineGray.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder18,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Opacity(
                                          opacity: 0.9,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 0.h,
                                              right: 0.h,
                                              top: 0.v,
                                            ),
                                            child: Text(
                                              "$transactionDateTime" + "      ",
                                              style: theme.textTheme.titleLarge,
                                            ),
                                          ),
                                        ),
                                        Opacity(
                                          opacity: 0.9,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 0.h,
                                              right: 0.h,
                                              top: 0.v,
                                            ),
                                            child: Text(
                                              "$amount",
                                              style: theme.textTheme.titleLarge,
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

  Future<String> getFarmerNameFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? '';
  }
}
