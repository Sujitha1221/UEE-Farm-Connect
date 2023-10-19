import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:form_structure/widgets/custom_text_form_field.dart';

import '../../widgets/custom_search_view.dart';

class Bidding {
  String farmerUserName;
  String userName;
  String productName;
  String weight;
  String amountPerKg;
  String totalAmount;

  Bidding(
      {required this.farmerUserName,
      required this.userName,
      required this.productName,
      required this.weight,
      required this.amountPerKg,
      required this.totalAmount});

  Map<String, dynamic> toJson() {
    return {
      'farmerUserName': farmerUserName,
      'userName': userName,
      'productName': productName,
      'weight': weight,
      'amountPerKg': amountPerKg,
      'totalAmount': totalAmount
    };
  }
}

class RequestBiddingPage extends StatefulWidget {
  RequestBiddingPage({Key? key})
      : super(
          key: key,
        );

  @override
  _RBScreenState createState() => _RBScreenState();
}

class _RBScreenState extends State<RequestBiddingPage> {
  List<Map<String, dynamic>> biddingList = [];
  late http.Client client;

  @override
  void initState() {
    super.initState();
    client = http.Client();

    @override
    void initState() {
      super.initState();
      client = http.Client();
    }
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  TextEditingController farmerUserNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController productNameController =
      TextEditingController(text: "productName");
  TextEditingController weightController = TextEditingController(text: "32");
  TextEditingController amountPerKgController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();

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
                                  "Request Bidding",
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
                        controller: productNameController,
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 52.v,
                          right: 25.h,
                        ),
                        hintText: "Product Name",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27.h, 15.v, 17.h, 15.v),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgIrrigation,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 54.v,
                        ),
                      ),
                      CustomTextFormField(
                        controller: weightController,
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 52.v,
                          right: 25.h,
                        ),
                        hintText: "Weight",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27.h, 15.v, 17.h, 15.v),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgKitchenscales,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 54.v,
                        ),
                      ),
                      CustomTextFormField(
                        controller: amountPerKgController,
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 52.v,
                          right: 25.h,
                        ),
                        hintText: "Amount Per KG",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(27.h, 15.v, 17.h, 15.v),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgUsDollarCircled,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 54.v,
                        ),
                      ),
                      CustomSearchView(
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 52.v,
                          right: 25.h,
                        ),
                        controller: totalAmountController,
                        hintText: "Total Amount",
                        hintStyle: CustomTextStyles.titleBlack,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(14.h, 10.v, 5.h, 10.v),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgUsDollarCircled,
                            color: Colors.black,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 41.v,
                        ),
                        suffix: Container(
                          margin: EdgeInsets.fromLTRB(30.h, 8.v, 15.h, 8.v),
                          child: CustomImageView(
                            svgPath: ImageConstant.imgCalculator,
                            color: Colors.black,
                            onTap: () => {
                              calculateTotalAmount()
                            },
                          ),
                        ),
                        suffixConstraints: BoxConstraints(
                          maxHeight: 41.v,
                        ),
                      ),
                      CustomElevatedButton(
                        text: "Request Bidding ",
                        margin: EdgeInsets.fromLTRB(37.h, 79.v, 23.h, 5.v),
                        onTap: () {
                          final bidding = Bidding(
                              farmerUserName: "sajeesiva12@gmail.com",
                              userName: "Sajeevan Siva",
                              productName: productNameController.text,
                              amountPerKg: amountPerKgController.text,
                              totalAmount: totalAmountController.text,
                              weight: weightController.text);
                          requestBidding(bidding);
                          makePayment(bidding);
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

  void calculateTotalAmount() {
    double amountPerKg = double.tryParse(amountPerKgController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;
    double totalAmount = weight * amountPerKg;
    totalAmountController.text = totalAmount.toString();
    print('Total Amount: $totalAmount');
  }

  Future requestBidding(Bidding bidding) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:8080/payment/new-payment'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
        "userNameTo" : bidding.farmerUserName,
        "userNameFrom": bidding.userName,
        "amount": bidding.totalAmount}),
      );

      if (response.body != null) {
        return response.body;
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to create bidding');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(
        'Failed to request bidding',
      );
    }
  }

  Future makePayment(Bidding bidding) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:8080/bidding/new-bidding'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bidding.toJson()),
      );

      if (response.body != null) {
        return response.body;
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to create bidding');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(
        'Failed to request bidding',
      );
    }
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: Image.asset('./././assets/images/RequstBiddingInfo.png'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
