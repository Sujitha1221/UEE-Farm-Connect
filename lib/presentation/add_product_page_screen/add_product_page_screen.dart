import 'dart:convert';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:form_structure/widgets/custom_elevated_button.dart';
import 'package:http/http.dart' as http;
import 'package:form_structure/widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Product {
  String productName;
  String farmerName;
  double quantity;
  double unitPrice;
  DateTime expiryDate;
  String photo;

  Product(
      {required this.productName,
      required this.farmerName,
      required this.quantity,
      required this.unitPrice,
      required this.expiryDate,
      required this.photo});

  Map<String, dynamic> toJson() {
    final formattedExpiryDate =
        "${expiryDate.year}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}";

    return {
      'productName': productName,
      'farmerName': farmerName,
      'quantity': quantity,
      'amountPerkg': unitPrice,
      'expiryDate': formattedExpiryDate,
      'photo': photo
    };
  }
}



// ignore: must_be_immutable
class AddProductPageScreen extends StatefulWidget {
  AddProductPageScreen({Key? key})
      : super(
          key: key,
        );

        @override
  _AddProductState createState()=> _AddProductState();

}


class _AddProductState extends State<AddProductPageScreen> {
   

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController amountPerkgController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  DateTime selectedDate = DateTime.now(); 

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
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/home_page_screen');
                              },
                            ),
                            Opacity(
                              opacity: 0.9,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 27.h,
                                  top: 10.v,
                                ),
                                child: Text(
                                  "Product Details",
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Show a dialog with the image
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Image.asset(
                                          'assets/images/img_calendar.png'), // Adjust the path to match your project structure
                                    );
                                  },
                                );
                              },
                              child: CustomImageView(
                                imagePath: ImageConstant.imgUnverifiedaccount,
                                height: 46.v,
                                width: 52.h,
                                margin: EdgeInsets.only(
                                  left: 2.h,
                                  bottom: 2.v,
                                ),
                              ),
                            )
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
                        textInputType: TextInputType.text,
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
                        controller: quantityController,
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 52.v,
                          right: 25.h,
                        ),
                        hintText: "Quantity",
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
                        controller: amountPerkgController,
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 52.v,
                          right: 25.h,
                        ),
                        hintText: "Amount Per kg",
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
                      CustomTextFormField(
  controller: expiryDateController,
  margin: EdgeInsets.only(
    left: 25.h,
    top: 52.v,
    right: 25.h,
  ),
  hintText: "Expiry Date",
  textInputAction: TextInputAction.done,
  textInputType: TextInputType.datetime, // Use TextInputType.datetime for the keyboard
  readOnly: true, // Make the field read-only
  onTap: () {
    _selectDate(context); // Call the date picker function
  },
  prefix: Container(
    margin: EdgeInsets.fromLTRB(27.h, 15.v, 17.h, 15.v),
    child: CustomImageView(
      imagePath: ImageConstant.imgCalendar,
    ),
  ),
  prefixConstraints: BoxConstraints(
    maxHeight: 54.v,
  ),
),

                      CustomElevatedButton(
                          onTap: () async {
                            String? photo = await pickAndConvertImage();
                            if (photo != null) {
                              photoController.text = photo;

                              // Handle the base64-encoded image string, e.g., send it to a server or display it in your UI
                              // You can use Image.memory to display the image in your UI
                              // Image.memory(base64Decode(base64Image))
                            }
                          },
                          text: 'Pick an Image',
                          margin: EdgeInsets.fromLTRB(100.h, 30.v, 100.h, 5.v)),
                      CustomElevatedButton(
                        text: "ADD",
                        margin: EdgeInsets.fromLTRB(37.h, 20.v, 23.h, 5.v),
                        onTap: () {
                          final product = Product(
                              productName: productNameController.text,
                              farmerName: "Sajeevan Siva",
                              quantity: double.parse(quantityController.text),
                              unitPrice:
                                  double.parse(amountPerkgController.text),
                              expiryDate:
                                  DateTime.parse(expiryDateController.text),
                              photo: photoController.text);

                          createProduct(product, context);
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

  Future<String?> pickAndConvertImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Compress the selected image
      final compressedImageBytes = await FlutterImageCompress.compressWithFile(
        pickedImage.path,
        quality: 70, // Set the desired image quality (0 to 100)
      );

      // Encode the compressed image bytes to a Base64-encoded string
      final base64String = base64Encode(compressedImageBytes!);

      return base64String;
    }

    return null; // Return null if no image is selected
  }

  Future createProduct(Product product, BuildContext context) async {
    try {
      final formattedExpiryDate = DateFormat('yyyy-MM-dd')
          .format(product.expiryDate); // Format the date

      product.expiryDate = DateFormat('yyyy-MM-dd').parse(formattedExpiryDate);
      final response = await http.post(
        Uri.parse('http://192.168.56.1:8080/product/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful request
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Success',
                style: TextStyle(
                  color: Colors.black, // Change the color to your desired color
                ),
              ),
              content: Text(
                'Product created successfully!',
                style: TextStyle(
                  color: Colors.black, // Change the color to your desired color
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Color.fromARGB(255, 12, 126,
                          15), // Change the color to your desired color
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).pushReplacementNamed(
                        '/view_product_page_farmer_screen'); // Navigate to the other page
                  },
                ),
              ],
            );
          },
        );
        return response.body;
      } else {
        // Handle error responses here
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to create product');
      }
    } catch (e) {
      // Handle network errors or other exceptions here
      print('Error: $e');
      throw Exception('Failed to create product (out)');
    }
  }

  Future<String> getEmpNameFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('empName') ??
        ''; // Provide a default value if 'empId' is not found
  }
  
  

  // Function to show the date picker
Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Use the selectedDate as the initial date
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    setState(() {
      selectedDate = picked; // Update the selectedDate
      expiryDateController.text = selectedDate.toString(); // Format as needed
    });
  }
}
}
