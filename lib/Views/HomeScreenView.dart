import 'package:dec/Views/TopNavbarScreens/AnalyticsScreenView.dart';
import 'package:dec/Views/TopNavbarScreens/DashboardScreenView.dart';
import 'package:dec/Views/TopNavbarScreens/InvestmentsScreenView.dart';
import 'package:flutter/material.dart';

import 'HelperViews/TabItem.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello Bangladesh"),
                  Text("Good Morning", style: TextStyle(fontSize: 14, color: Colors.grey),)
                ],
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.account_circle, size: 40,))
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.green.shade100,
                ),
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    TabItem(title: "Dashboard", count: 6),
                    TabItem(title: "Investments", count: 3),
                    TabItem(title: 'Analytics', count: 1),
                  ],
                ),
              ),
            ),
          )
      ),

      body: TabBarView(children: [
        Center(child: DashboardScreenView()),
        Center(child: InvestmentsScreenView()),
        Center(child: AnalyticsScreenView()),
      ]),

    ));
  }
}

