import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

String selectedValue = 'Option 1'; // Initialize with a default value

class Crop {
  String cropName;
  String count;
  String date;

  Crop({
    required this.cropName,
    required this.count,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'cropName': cropName,
      'count': count,
      'date': date,
    };
  }
}

class AddCropScreen extends StatefulWidget {
  AddCropScreen({Key? key}) : super(key: key);

  @override
  _AddCropScreenState createState() => _AddCropScreenState();
}

class _AddCropScreenState extends State<AddCropScreen> {
  String selectedValue = 'Option 1';

  TextEditingController dateController = TextEditingController();
  TextEditingController cropNameController = TextEditingController();
  TextEditingController countController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                                  "Add New Crop",
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
                      // CustomTextFormField(
                      //   controller: cropNameController,
                      //   margin: EdgeInsets.only(
                      //     left: 25.h,
                      //     top: 52.v,
                      //     right: 25.h,
                      //   ),
                      //   hintText: "Select Crop",
                      //   textInputAction: TextInputAction.done,
                      //   textInputType: TextInputType.emailAddress,
                      //   prefix: Container(
                      //     margin: EdgeInsets.fromLTRB(27.h, 15.v, 17.h, 15.v),
                      //     child: CustomImageView(
                      //       svgPath: ImageConstant.imgCalculator,
                      //     ),
                      //   ),
                      //   prefixConstraints: BoxConstraints(
                      //     maxHeight: 54.v,
                      //   ),
                      // ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
                          child: CustomDropdown<String>(
                            items: ['Option 1', 'Option 2', 'Option 3'],
                            value: selectedValue,
                            onChanged: (String newValue) {
                              setState(() {
                                selectedValue = newValue;
                              });
                            },
                            itemBuilder: (String item) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item,
                                  style: TextStyle(fontSize: 18.h),
                                ),
                              );
                            },
                          )),

                      CustomTextFormField(
                        controller: countController,
                        margin: EdgeInsets.only(
                          left: 25.h,
                          top: 25.v,
                          right: 25.h,
                        ),
                        hintText: "Enter Count",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
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
                      // GestureDetector(
                      //   onTap: () async {
                      //     final selectedDate = await showDatePicker(
                      //       context: context,
                      //       initialDate:
                      //           DateTime.now(), // Provide an initial date
                      //       firstDate: DateTime(
                      //           2000), // Provide the earliest date that can be selected
                      //       lastDate: DateTime(
                      //           2101), // Provide the latest date that can be selected
                      //     );

                      //     if (selectedDate != null) {
                      //       // Handle the selected date, e.g., update the text field with the selected date.
                      //       dateController.text =
                      //           selectedDate.toLocal().toString();
                      //     }
                      //   },
                      //   child: CustomTextFormField(
                      //     controller: dateController,
                      //     margin: EdgeInsets.only(
                      //       left: 25.h,
                      //       top: 25.v,
                      //       right: 25.h,
                      //     ),
                      //     hintText: "Select Date",
                      //     textInputAction: TextInputAction.done,
                      //     textInputType: TextInputType.datetime,
                      //     prefix: Container(
                      //       margin: EdgeInsets.fromLTRB(27.h, 15.v, 17.h, 15.v),
                      //       child: CustomImageView(
                      //         svgPath: ImageConstant.imgCalculator,
                      //       ),
                      //     ),
                      //     prefixConstraints: BoxConstraints(
                      //       maxHeight: 54.v,
                      //     ),
                      //   ),
                      // ),
                      Container(
                          padding: EdgeInsets.fromLTRB(25.h, 0, 20.h, 0),
                          margin: EdgeInsets.only(
                            left: 25.h,
                            top: 25.v,
                            right: 25.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green[900]!),
                            borderRadius: BorderRadius.circular(26.h),
                          ),
                          child: Center(
                              child: TextField(
                            controller: dateController,
                            style: TextStyle(fontSize: 18.h),
                            //editing controller of this TextField
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today,
                                    color: Colors.green[900]!),
                                hintText: "Select Date" //icon of text field
                                // labelText: "Enter Date" //label text of field
                                ),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  dateController.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          ))),

                      CustomElevatedButton(
                        text: "Add Crop",
                        margin: EdgeInsets.fromLTRB(37.0, 79.0, 23.0, 5.0),
                        onTap: () {
                          final crop = Crop(
                            cropName: cropNameController.text,
                            count: countController.text,
                            date: dateController.text,
                          );

                          createCrop(context, crop);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future createCrop(BuildContext context, Crop crop) async {
  try {
    final response = await http.post(
      Uri.parse('http://192.168.56.1:8080/crop/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(crop.toJson()), // Convert Crop object to JSON
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Crop created successfully"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to create crop"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to create crop: $e"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        });
    print('Error: $e');
  }
}
