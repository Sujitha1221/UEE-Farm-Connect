import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/core/utils/image_constant.dart';
import 'package:form_structure/theme/custom_text_style.dart';
import 'package:form_structure/widgets/app_bar/appbar_image.dart';
import 'package:form_structure/widgets/app_bar/appbar_image_1.dart';
import 'package:form_structure/widgets/app_bar/appbar_subtitle.dart';
import 'package:build_zone/widgets/app_bar/custom_app_bar.dart';

class PRScreen extends StatefulWidget {
  PRScreen({Key? key}) : super(key: key);

  @override
  _PRScreenState createState() => _PRScreenState();
}

class _PRScreenState extends State<PRScreen> {
  List<Map<String, dynamic>> prList = [];
  late http.Client client;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    fetchPurchaseRequisitions();
  }

  Future<void> fetchPurchaseRequisitions() async {
    final List<Map<String, dynamic>>? fetchedPRList = await getAllPR(context);
    if (fetchedPRList != null) {
      setState(() {
        prList = fetchedPRList;
      });
    }
  }

  Future<String> getEmpIdFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('empId') ??
        ''; // Provide a default value if 'empId' is not found
  }

  Future<List<Map<String, dynamic>>?> getAllPR(BuildContext context) async {
    try {
      final empid = await getEmpIdFromLocalStorage();
      final response = await client.get(
        Uri.parse(
            'http://192.168.56.1:8080/purchase-requisition/get-pr-by-empid/$empid'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Explicitly cast the result to the correct type
        final List<Map<String, dynamic>> prList =
            (json.decode(response.body) as List)
                .map((item) => item as Map<String, dynamic>)
                .toList();
        return prList;
      } else {
        // Handle error responses here
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch purchase requisitions');
      }
    } catch (e) {
      // Handle network errors or other exceptions here
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingWidth: 64.h,
          leading: AppbarImage(
            imagePath: ImageConstant.imgWorkers,
            margin: EdgeInsets.only(
              left: 22.h,
              top: 7.v,
              bottom: 7.v,
            ),
          ),
          title: Container(
            height: 38.99.v,
            width: 111.h,
            margin: EdgeInsets.only(left: 9.h),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 6.v),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Build",
                            style: CustomTextStyles.headlineSmallBlack90024,
                          ),
                          TextSpan(
                            text: "Zone",
                            style: CustomTextStyles.headlineSmallOrange500,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                AppbarSubtitle(
                  text: "S     O     L     U     T     I     O     N     S",
                  margin: EdgeInsets.only(
                    left: 10.h,
                    top: 31.v,
                    right: 17.h,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            AppbarImage1(
              imagePath: ImageConstant.imgGroup10,
              margin: EdgeInsets.fromLTRB(26.h, 16.v, 26.h, 15.v),
              onTap: () async {
                // Show an alert dialog to confirm logout
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Confirm Logout'),
                      content: Text('Are you sure you want to log out?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: Text('OK'),
                          onPressed: () async {
                            // User pressed "OK," call the removePrefs function
                            Navigator.of(context).pop(); // Close the dialog
                            await removePrefs(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 54, vertical: 28),
            child: Column(
              children: [
                Text(
                  "Purchase Requisitions",
                  style: CustomTextStyles.titleLargeBlack90022,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: prList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> prod = prodList[index];
                    String productName = prod['productName'] ?? "Unknown Product";
                    String farmerName = prod['farmerName'] ?? "Unknown";
                    String quantity = prod['quantity'];
                    String amountPerkg = prod['amountPerkg'] ?? "Pending";
                    String expiryDate = prod['expiryDate'] ?? "Null";
                    String photo = prod['photo'];
                    return  Container(
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
                                            "Farmer : $farmerName",
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
                                            "$productName",
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
                                              "$quantity kg\nPrice per kg:-",
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
                                              "$amountPerkg",
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
                                              "$expiryDate",
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
              
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/add_pr_screen');
            // Handle the action when the FAB is pressed
            // You can navigate to another screen or perform an action here
          },
          backgroundColor: Color(0xFFFE9901),
          child: Icon(
            Icons.add,
            color: Colors.white, // Set the icon color to white
          ),
        ),
      ),
    );
  }

  Future<void> removePrefs(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('empId');
    Navigator.of(context).pushReplacementNamed('/login_screen');
  }

  Color getColorForStatus(String status) {
    switch (status) {
      case "Pending":
        return Color(0xFFFE9901); // Set to yellow for pending status
      case "Approved":
        return Colors.green; // Set to green for accepted status
      case "Rejected":
        return Colors.red;
      case "Order Placed":
        return Colors.blueAccent; // Set to red for rejected status
      default:
        return Colors
            .transparent; // Set a default color or handle other statuses
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: PRScreen(),
  ));
}
