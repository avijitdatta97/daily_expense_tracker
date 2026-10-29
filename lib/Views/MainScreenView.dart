import 'package:dec/Views/HomeScreenView.dart';
import 'package:dec/Views/SettingScreenView.dart';
import 'package:dec/Views/TransactionsScreenView.dart';
import 'package:flutter/material.dart';

import 'BottomNavbarScreens/ChatScreenView.dart';

class MainScreenView extends StatefulWidget {
  static const String routeName = '/mainPage';

  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> screenOptions = const [
    HomeScreenView(),
    TransactionsScreenView(),
    ChatScreenView(),
    SettingScreenView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Setting",
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        elevation: 1,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),

      body: screenOptions.elementAt(_selectedIndex),
    );
  }
}
