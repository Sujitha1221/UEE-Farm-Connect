import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/presentation/update_crop_screen/update_crop_screen.dart';
import 'package:form_structure/presentation/weather_screen/weather_screen.dart';
import 'package:form_structure/widgets/custom_linear_progress.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../core/utils/image_constant.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_image_view.dart';

class Crop {
  String id;
  String cropName;
  int count;
  String date;

  Crop({
    required this.id,
    required this.cropName,
    required this.count,
    required this.date,
  });

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      id: json['_id'],
      cropName: json['cropName'],
      count: json['count'],
      date: json['date'],
    );
  }
}

class CropListScreen extends StatefulWidget {
  @override
  _CropListScreenState createState() => _CropListScreenState();
}

class _CropListScreenState extends State<CropListScreen> {
  final String apiUrl = 'http://172.28.14.76:8080/crop';

  List<Crop> crops = []; // List to store the fetched crops

  @override
  void initState() {
    super.initState();
    fetchCrops();
  }

  Future<void> fetchCrops() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> cropData = jsonDecode(response.body);
        setState(() {
          crops = cropData.map((data) => Crop.fromJson(data)).toList();
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      Center(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                            child: Text(
                              'Planted Crops',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24.h),
                            )),
                      ),
                      Container(
                          height: 500,
                          margin: EdgeInsets.fromLTRB(
                              0, 20.h, 0, 0), // Set your desired height here
                          child: ListView.builder(
                            itemCount: crops.length,
                            itemBuilder: (context, index) {
                              final crop = crops[index];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateCropScreen(cropId: crop.id),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      margin: EdgeInsets.all(8.0),
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/${crop.cropName}.jpg'),
                                            width: 100, // Set the desired width
                                            height:
                                                100, // Set the desired height
                                            fit: BoxFit
                                                .contain, // You can choose a fit option
                                          ),

                                          SizedBox(
                                              width:
                                                  16), // Add some spacing between the image and text
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${crop.cropName}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.h),
                                              ),
                                              Text('Count: ${crop.count}'),
                                              Text(
                                                  'Planted Date: ${formatToCustomDate(crop.date)}'),
                                              Text(
                                                  'Expected Harvest Date: ${formatToCustomDateFuture(crop.date, expectedDays(crop.cropName))}'),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10.h, 0, 0),
                                                  child: SizedBox(
                                                    width: 220.h,
                                                    height: 15.v,
                                                    child:
                                                        CustomLinearProgressIndicator(
                                                      colors: [
                                                        Colors.green[100]!,
                                                        Colors.green[800]!
                                                      ],
                                                      value: calculateProgress(
                                                          DateTime.parse(
                                                              crop.date),
                                                          DateTime.parse(
                                                                  crop.date)
                                                              .add(Duration(
                                                                  days: expectedDays(
                                                                      crop.cropName)))),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      )));
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => WeatherScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black),
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      50.h, 10.h, 50.h, 10.h),
                                  child: Text(
                                    'View Weather',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ))))
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/add_crop_screen');
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.green[900],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

String formatToCustomDate(String date) {
  final formatter = DateFormat('dd-MM-yyyy');
  return formatter.format(DateTime.parse(date));
}

String formatToCustomDateFuture(String date, int daysToAdd) {
  final formatter = DateFormat('dd-MM-yyyy');
  final initialDate = DateTime.parse(date);
  final finalDate = initialDate.add(Duration(days: daysToAdd));
  return formatter.format(finalDate);
}

double calculateProgress(DateTime plantedDate, DateTime expectedHarvestDate) {
  DateTime currentDate = DateTime.now();
  if (currentDate.isBefore(plantedDate)) {
    return 0.0;
  } else if (currentDate.isAfter(expectedHarvestDate)) {
    return 1.0;
  } else {
    double totalDays =
        expectedHarvestDate.difference(plantedDate).inDays.toDouble();
    double elapsedDays = currentDate.difference(plantedDate).inDays.toDouble();
    return elapsedDays / totalDays;
  }
}

int expectedDays(String cropName) {
  if (cropName == 'Carrot') {
    return 60;
  } else if (cropName == 'Onion') {
    return 90;
  } else if (cropName == 'Tomato') {
    return 100;
  } else if (cropName == 'Potato') {
    return 80;
  } else {
    return 90;
  }
}

void main() {
  runApp(MaterialApp(
    home: CropListScreen(),
  ));
}
