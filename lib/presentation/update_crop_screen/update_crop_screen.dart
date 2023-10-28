import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

// Define a class for the Crop object, similar to what you did in AddCropScreen
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

  // Add a factory method to deserialize from JSON if needed
  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      cropName: json['cropName'],
      count: json['count'],
      date: json['date'],
    );
  }
}

class UpdateCropScreen extends StatefulWidget {
  final String cropId;

  UpdateCropScreen({required this.cropId});

  @override
  _UpdateCropScreenState createState() => _UpdateCropScreenState();
}

class _UpdateCropScreenState extends State<UpdateCropScreen> {
  String selectedValue = 'Carrot';

  TextEditingController dateController =
      TextEditingController(text: '28-10-2023');
  TextEditingController cropNameController =
      TextEditingController(text: 'Carrot');
  TextEditingController countController = TextEditingController(text: '50');

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
                              onTap: () => {
                                Navigator.of(context)
                                    .pushReplacementNamed('/view_crop_screen')
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
                                  "Update Crop",
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
                            items: ['Carrot', 'Tomato', 'Potato', 'Onion'],
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
                        text: "Update Crop",
                        margin: EdgeInsets.fromLTRB(37.0, 79.0, 23.0, 5.0),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final crop = Crop(
                              cropName: selectedValue,
                              count: countController.text,
                              date: dateController.text,
                            );
                            if (isValidCount(countController.text)) {
                              if (isValidDate(dateController.text)) {
                                updateCrop(context, widget.cropId, crop);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content:
                                          Text("Please enter a valid date"),
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
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text("Please enter a valid count"),
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
                            }
                          }
                        },
                      ),
                      Padding(
                          padding:
                              EdgeInsets.all(8.0), // Set margin for the button
                          child: Container(
                              margin: EdgeInsets.all(
                                  8.0), // Set padding for the button
                              child: ElevatedButton(
                                onPressed: () {
                                  // Show a confirmation dialog before deleting
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Confirm Deletion"),
                                        content: Text(
                                            "Are you sure you want to delete this crop?"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the confirmation dialog
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Close the confirmation dialog and delete the crop
                                              deleteCrop(
                                                  context, widget.cropId);

                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      '/view_crop_screen');
                                            },
                                            child: Text("Delete"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        100.h, 10.h, 100.h, 10.h),
                                    child: Text(
                                      "Delete Crop",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red[
                                      900], // Change this color to your desired color
                                ),
                              )))
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

Future updateCrop(BuildContext context, String cropId, Crop crop) async {
  try {
    final response = await http.put(
      Uri.parse(
          'http://172.28.14.76:8080/crop/$cropId'), // Replace with your API endpoint for updating a crop
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(crop.toJson()), // Convert Crop object to JSON
    );

    if (response.statusCode == 200) {
      // Handle success
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Crop updated successfully"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed('/view_crop_screen');
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to update crop"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              )
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
          content: Text("Failed to update crop"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }
}

Future deleteCrop(BuildContext context, String cropId) async {
  try {
    final response = await http.delete(
      Uri.parse(
          'http://172.28.14.76:8080/crop/$cropId'), // Replace with your delete API endpoint
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed('/view_crop_screen');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to delete crop"),
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
          content: Text("Failed to delete crop: $e"),
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
    print('Error: $e');
  }
}

bool isValidDate(String input) {
  try {
    DateFormat('yyyy-MM-dd').parse(input);
    return true;
  } catch (e) {
    return false;
  }
}

bool isValidCount(String input) {
  try {
    int count = int.parse(input);
    return count >= 0;
  } catch (e) {
    return false;
  }
}
