import 'package:flutter/material.dart';

import 'TransactionsPartView.dart';

class DashboardScreenView extends StatefulWidget {
  const DashboardScreenView({super.key});

  @override
  State<DashboardScreenView> createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildWalletView(),
          
              // Method
              Row(
                children: [
                  Expanded(
                    child: _buildMethodItem(Icons.arrow_circle_up, "Top Up"),
                  ),
                  Expanded(
                    child: _buildMethodItem(Icons.arrow_circle_down, "Received"),
                  ),
                  Expanded(child: _buildMethodItem(Icons.credit_card, "Send")),
                  Expanded(child: _buildMethodItem(Icons.money, "Payment")),
                ],
              ),
          
              // Transaction
              TransactionsPartView(),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildMethodItem(IconData icon, String name) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 1.0),
        // This keeps the rounded corners that Card has by default
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
        child: Column(
          children: [
            Icon(icon, size: 28),
            SizedBox(height: 6),
            Text(name, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Card _buildWalletView() {
    return Card(
      color: Colors.green,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green.shade700,
                  child: Icon(
                    Icons.add_card_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                  radius: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Wallet Balance",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Update: 12/03/2026",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Center(
                child: Text(
                  "\$1200.00",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  spacing: 24,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Row(
                          spacing: 16,
                          children: [
                            Column(children: [Icon(Icons.currency_exchange)]),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Expense",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "\$362.00",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          spacing: 16,
                          children: [
                            Column(children: [Icon(Icons.currency_exchange)]),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Income",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "\$349.00",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

