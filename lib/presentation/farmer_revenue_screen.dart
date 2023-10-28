import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/widgets/custom_bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RevenuePage extends StatefulWidget {
  @override
  _RevenuePageState createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  late Future<List<Payment>> payments; // Make it non-nullable using 'late'

  @override
  void initState() {
    super.initState();
    payments = fetchPayments();
  }

  Future<List<Payment>> fetchPayments() async {
    String? userName = await getUserNameFromPrefs();
    print(userName);
    final response = await http.get(
      Uri.parse(
          'http://172.28.14.76:8080/payment/payments?userName=$userName&type=Receive'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Payment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load payments');
    }
  }

  Future<String?> getUserNameFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs);
    return prefs.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Revenue Chart"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.farmerDashboardScreen);
          },
        ),
      ),
      body: FutureBuilder<List<Payment>>(
        future: payments,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RevenueChart(payments: snapshot.data!),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        onChanged: (BottomBarEnum type) {},
      ),
    );
  }
}

class Payment {
  final String userName;
  final String amount;
  final String type;
  final String transactionDateTime;

  Payment(
      {required this.userName,
      required this.amount,
      required this.type,
      required this.transactionDateTime});

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
        userName: json['userName'],
        amount: json['amount'],
        type: json['type'],
        transactionDateTime: json['transactionDateTime']);
  }
}

class RevenueChart extends StatelessWidget {
  final List<Payment> payments;

  RevenueChart({required this.payments});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: getMaxY(),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: const Color(0xff37434d),
            width: 1,
          ),
        ),
        barGroups: getBarGroups(),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups() {
    return List.generate(
        payments.length,
        (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: double.parse(payments[i].amount),
                  color: Colors.lightBlueAccent,
                ),
              ],
              showingTooltipIndicators: [0],
            ));
  }

  double getMaxY() {
    return payments
        .map((payment) => double.parse(payment.amount))
        .fold(0.0, (a, b) => a > b ? a : b);
  }
}
