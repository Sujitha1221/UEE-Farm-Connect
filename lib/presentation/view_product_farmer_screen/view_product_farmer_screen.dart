import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:form_structure/widgets/custom_search_view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewPageFarmerScreen extends StatefulWidget {
  ViewPageFarmerScreen({Key? key}) : super(key: key);

  @override
  _ViewFarmerState createState()=> _ViewFarmerState();

}

class _ViewFarmerState extends State<ViewPageFarmerScreen> {
  List<Map<String, dynamic>> prodList = [];
  late http.Client client;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
  final Map<String, dynamic>? fetchedProdData = await getAllProducts(context);
  if (fetchedProdData != null) {
    setState(() {
      // Check the structure of your response and access the product list accordingly.
      if (fetchedProdData.containsKey("products")) {
        prodList = List<Map<String, dynamic>>.from(fetchedProdData["products"]);
      } else {
        prodList = []; // Empty list if "products" key is not found in response.
      }
    });
  }
}


  Future<String> getFarmerNameFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('farmerName') ??
        ''; // Provide a default value if 'empId' is not found
  }

  List<Map<String, dynamic>> filterProducts(String searchText) {
  return prodList.where((product) {
    final productName = product['productName'].toLowerCase();
    return productName.contains(searchText.toLowerCase());
  }).toList();
}


  Future<Map<String, dynamic>?> getAllProducts(BuildContext context) async {
  try {
    // final farmerName = await getFarmerNameFromLocalStorage();
    final farmerName = "Sajeevan Siva";
    final response = await client.get(
      Uri.parse('http://192.168.56.1:8080/product/get/$farmerName'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Explicitly cast the result to the correct type (Map)
      final Map<String, dynamic> productData = json.decode(response.body);
      return productData;
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
                            Builder(
  builder: (context) {
    final filteredProducts = filterProducts(searchController.text);
    return ListView.builder(
                            
                              
                                itemCount: filterProducts(searchController.text).length,
                  shrinkWrap: true,
                  itemExtent: 220,
                  // itemCount: prodList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> prod = prodList[index];
                    String productName = prod['productName'] ?? "Unknown Product";
                    String quantity = prod['quantity'].toString();
                    print(quantity);
                    String amountPerkg = prod['amountPerkg'].toString() ?? "Pending";
                    String expiryDate = prod['expiryDate'].toString().substring(0,10) ?? "Null";
                    String photo = prod['photo'];
                    String id = prod['_id'];

                    List<int> bytes = base64Decode(photo);
                    return  Container(
                      margin: EdgeInsets.symmetric(vertical: 10), // Add vertical spacing between items
      padding: EdgeInsets.all(10),
                              
                          
                              
                              decoration: AppDecoration.outlineGray.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder18,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                               
                                children: [
                                  Opacity(
                                    opacity: 0.9,
                                    
                                    child: Image.memory(
            Uint8List.fromList(bytes), // Convert bytes to Uint8List
            width: 150, // Set the image width as needed
            height: 150,
           

            
             // Set the image height as needed
          ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.v,right: 50.v),
                                    child: Column(
                                      children: [
                                        
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
                                              "Rs.$amountPerkg.00",
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
                                                Opacity(
                                                  opacity: 0.9,
                                                  child: CustomImageView(
                                                    imagePath: ImageConstant.imgDelete,
                                                    height: 34.adaptSize,
                                                    width: 34.adaptSize,
                                                    margin: EdgeInsets.only(top: 14.v),
                                                    onTap: () {
    confirmDeleteProduct(context, id);
  },
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
                            );
                            
              
                  },
                );
  },
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
        floatingActionButton: Positioned(
      bottom: 16.0, // Adjust the position as needed
      right: 16.0, // Adjust the position as needed
      child: FloatingActionButton(
        backgroundColor: Color(0xFF255B20),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/add_product_page_screen');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    ),
        
      // Adjust the location as needed
    ),
    );
      
  }
  
  Future<void> deleteProduct(String id) async {
  try {
    final response = await client.delete(
      Uri.parse('http://192.168.56.1:8080/product/delete/$id'), // Replace with your API endpoint
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Product deletion was successful
      print('Product with ID $id has been deleted.');
      // You can also update your product list or perform other actions here.
    } else {
      // Handle error responses here
      print('Failed to delete product with ID $id. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to delete the product');
    }
  } catch (e) {
    // Handle network errors or other exceptions here
    print('Error: $e');
    // You can choose to rethrow the exception or handle it as needed.
  }
}

Future<void> confirmDeleteProduct(BuildContext context, String id) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap a button to dismiss the dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
       
        title: Text(
    'Confirm Deletion',
    style: TextStyle(
      color: Colors.black, // Change the color to your desired color
    ),
  ),
        content: Text('Are you sure you want to delete this product?',style: TextStyle(
      color: Colors.black, // Change the color to your desired color
    ),),
        
       
        actions: <Widget>[
          TextButton(
            child: Text(
    'Cancel',
    style: TextStyle(
      color: Colors.black, // Change the color to your desired color
    ),
  ),
            onPressed: () {
              // Close the dialog without deleting the product
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            child: Text('Delete',style: TextStyle(
      color: Colors.red, // Change the color to your desired color
    ),),
            onPressed: () async {
              // Close the dialog and delete the product
              Navigator.of(dialogContext).pop();
              await deleteProduct(id);
              // You can add further logic or UI updates here after the product is deleted.
            },
          ),
        ],
      );
    },
  );
}




}

