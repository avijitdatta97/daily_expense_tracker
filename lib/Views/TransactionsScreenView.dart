import 'package:dec/utilities/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utilities/helper_list.dart';
import 'HelperViews/TransactionForm.dart';

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
                  "Manage financial records",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _showBottomSheet(context);
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
              child: Builder(
                builder: (context) {
                  final filteredTransactions = selectedCategory == "All"
                      ? transactionDataList
                      : transactionDataList.where((transaction) {
                          return transaction.transactionType.toLowerCase() ==
                              selectedCategory.toLowerCase();
                        }).toList();

                  return ListView.builder(
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];

                      final String transactionDate =
                          "${transaction.transactionDate.day}/"
                          "${transaction.transactionDate.month}/"
                          "${transaction.transactionDate.year}";

                      final bool isIncome =
                          transaction.transactionType.toLowerCase() == 'income';

                      return _buildTransactionCard(
                        transaction,
                        transactionDate,
                        isIncome,
                      );
                    },
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
      dynamic transaction,
      String transactionDate,
      bool isIncome,
      ) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(transaction.transactionName),
        subtitle: Text(transactionDate),

        leading: CircleAvatar(
          backgroundColor: isIncome
              ? Colors.green.shade100
              : Colors.red.shade100,
          child: isIncome
              ? const Icon(
            Icons.call_received,
            color: Colors.green,
          )
              : const Icon(
            Icons.call_made,
            color: Colors.red,
          ),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${isIncome ? '+' : '-'}\$"
                  "${transaction.transactionAmount.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isIncome ? Colors.green : Colors.red,
              ),
            ),

            const SizedBox(width: 14),

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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DefaultTabController(
            length: 2,
            child: Container(
              padding: EdgeInsets.all(16),
              height: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Center(
                    child: Text(
                      "Enter Your Transaction",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  /// Tabs
                  TabBar(
                    indicatorColor: Colors.green,
                    indicatorWeight: 3,
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Income"),
                      Tab(text: "Expense"),
                    ],
                  ),

                  SizedBox(height: 10),

                  /// Tab Content
                  Expanded(
                    child: TabBarView(
                      children: [
                        TransactionForm(type: "Income"),
                        TransactionForm(type: "Expense"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
