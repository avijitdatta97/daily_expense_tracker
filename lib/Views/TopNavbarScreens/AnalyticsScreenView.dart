import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'TransactionsPartView.dart';

class AnalyticsScreenView extends StatefulWidget {
  const AnalyticsScreenView({super.key});

  @override
  State<AnalyticsScreenView> createState() => _AnalyticsScreenViewState();
}

class _AnalyticsScreenViewState extends State<AnalyticsScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                color: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey, width: 1.0),
                  // This keeps the rounded corners that Card has by default
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Expense",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "\$8,343.0",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green.shade50,
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: DropdownMenu(
                              initialSelection: "Week",
                              onSelected: (value) {},
                              dropdownMenuEntries: [
                                DropdownMenuEntry(value: "Day", label: "Day"),
                                DropdownMenuEntry(value: "Week", label: "Week"),
                                DropdownMenuEntry(value: "Month", label: "Month"),
                              ],
                              inputDecorationTheme: InputDecorationTheme(
                                // Makes the dropdown more compact
                                isDense: true,
                                // Adjusts padding inside the capsule
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                // Default border
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  // Capsule shape
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                // Border when enabled
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  // Capsule shape
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                // Border when focused (tapped)
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  // Capsule shape
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        height: 250,
                        padding: EdgeInsets.all(10.0),
                        child: PieChart(PieChartData(
                          sectionsSpace: 4,
                            sections: [
                          PieChartSectionData(value: 10, color: Colors.red, titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          PieChartSectionData(value: 20, color: Colors.teal, titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          PieChartSectionData(value: 30, color: Colors.blue, titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          PieChartSectionData(value: 40, color: Colors.purple, titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ])),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                Text("Business"),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                Text("Food"),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                Text("Education"),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.tealAccent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                Text("Other"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              TransactionsPartView(),
            ],
          ),
        ),
      ),
    );
  }
}
