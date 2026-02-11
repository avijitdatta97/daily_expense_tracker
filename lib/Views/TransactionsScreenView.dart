import 'package:dec/utilities/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/TransactionModel.dart';
import '../utilities/helper_list.dart';

class TransactionsScreenView extends StatefulWidget {
  const TransactionsScreenView({super.key});

  @override
  State<TransactionsScreenView> createState() => _TransactionsScreenViewState();
}

class _TransactionsScreenViewState extends State<TransactionsScreenView> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Transactions"),
                Text(
                  "Manage your detailed financial records",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                showSnackBar(context, "title", "action");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.add),
                  Text(
                    "Add New",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            /// Category Button
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 10,
                children: [
                  _buildChoiceChip("All"),
                  _buildChoiceChip("Income"),
                  _buildChoiceChip("Expense"),
                ],
              ),
            ),

            /// Search Button
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Form(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintText: "Search Transactions...",
                    hintStyle: TextStyle(color: Colors.grey),
                    // Standard Border (Fallback)
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Radius 10
                      borderSide: BorderSide(
                        color: Color(0xFFD8DADC),
                        width: 1,
                      ),
                    ),
                    // Enabled Border (State when field is not focused)
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Radius 10
                      borderSide: BorderSide(
                        color: Color(0xFFD8DADC),
                        width: 1,
                      ),
                    ),
                    // Focused Border (State when typing - keeping radius consistent)
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Radius 10
                      borderSide: BorderSide(
                        color: Color(0xFFD8DADC),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// List View
            Expanded(
              child: ListView.builder(
                itemCount: transactionDataList.length,
                itemBuilder: (cotext, index) {
                  final String transactionDate =
                      "${transactionDataList[index].transactionDate.day}/" +
                      "${transactionDataList[index].transactionDate.month}/" +
                      "${transactionDataList[index].transactionDate.year}";
                  final bool _isIncome =
                      transactionDataList[index].transactionType == 'income'
                      ? true
                      : false;
                  return _buildTransactionCard(
                    index,
                    transactionDate,
                    _isIncome,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(
    int index,
    String transactionDate,
    bool _isIncome,
  ) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),

      child: ListTile(
        title: Text(transactionDataList[index].transactionName),
        subtitle: Text(transactionDate),
        leading: CircleAvatar(
          backgroundColor: _isIncome
              ? Colors.green.shade100
              : Colors.red.shade100,
          child: _isIncome
              ? Icon(
                  Icons.call_received,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                )
              : Icon(
                  Icons.call_made,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 14,
          children: [
            Text(
              "${_isIncome ? '+' : '-'}\$${transactionDataList[index].transactionAmount.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _isIncome ? Colors.green : Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                showAlertDialog(
                  context,
                  "Deleted",
                  "Are you sure, want to delete transaction data?",
                  "Cancel",
                  "Delete",
                  Colors.green,
                  Colors.red,
                );
              },
              icon: SvgPicture.asset(
                "images/delete_icon.svg",
                width: 22,
                height: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: selectedCategory == label ? Colors.white : Colors.black54,
        ),
      ),
      selected: selectedCategory == label,
      selectedColor: Colors.green,
      backgroundColor: Colors.green.shade100,
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: selectedCategory == label
              ? Colors.green
              : Colors.grey.shade300,
        ),
      ),
      onSelected: (bool selected) {
        setState(() {
          selectedCategory = label;
        });
      },
    );
  }
}
