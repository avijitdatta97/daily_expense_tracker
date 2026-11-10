import 'package:dec/models/TransactionModel.dart';
import 'package:dec/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'HelperViews/TransactionForm.dart';

class TransactionsScreenView extends StatefulWidget {
  const TransactionsScreenView({super.key});

  @override
  State<TransactionsScreenView> createState() => _TransactionsScreenViewState();
}

class _TransactionsScreenViewState extends State<TransactionsScreenView> {
  String selectedCategory = "All";
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final now = DateTime.now();
      context.read<TransactionProvider>().fetchTransactions(
            month: now.month,
            year: now.year,
          );
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
              child: const Row(
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

            /// Search Input Field
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Search Transactions...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFD8DADC),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFD8DADC),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFFD8DADC),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            /// List View
            Expanded(
              child: transactionProvider.isFetchingTransactions
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    )
                  : Builder(
                      builder: (context) {
                        var list = transactionProvider.transactions;

                        // Filter by Category
                        if (selectedCategory != "All") {
                          list = list.where((t) {
                            return t.type.toLowerCase() ==
                                selectedCategory.toLowerCase();
                          }).toList();
                        }

                        // Filter by Search Query
                        if (_searchQuery.isNotEmpty) {
                          list = list.where((t) {
                            final name = t.transactionName.toLowerCase();
                            final cat = t.categoryName.toLowerCase();
                            final subcat = t.subcategoryName.toLowerCase();
                            final note = (t.note ?? '').toLowerCase();
                            return name.contains(_searchQuery) ||
                                cat.contains(_searchQuery) ||
                                subcat.contains(_searchQuery) ||
                                note.contains(_searchQuery);
                          }).toList();
                        }

                        //check empty list
                        if (list.isEmpty) {
                          return const Center(
                            child: Text(
                              "No transactions found",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          );
                        }

                        return RefreshIndicator(
                          onRefresh: () async {
                            final now = DateTime.now();
                            await transactionProvider.fetchTransactions(
                              month: now.month,
                              year: now.year,
                            );
                          },
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final transaction = list[index];
                              final String transactionDate =
                                  "${transaction.transactionDate.day}/"
                                  "${transaction.transactionDate.month}/"
                                  "${transaction.transactionDate.year}";

                              final bool isIncome =
                                  transaction.type.toLowerCase() == 'income';

                              return _buildTransactionCard(
                                transaction,
                                transactionDate,
                                isIncome,
                              );
                            },
                          ),
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
    TransactionModel transaction,
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
        subtitle: Text(
          "$transactionDate${transaction.note != null && transaction.note!.isNotEmpty ? ' • ${transaction.note}' : ''}",
        ),
        leading: CircleAvatar(
          backgroundColor:
              isIncome ? Colors.green.shade100 : Colors.red.shade100,
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
              "${isIncome ? '+' : '-'}${transaction.amount.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isIncome ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 14),
            IconButton(
              onPressed: () {
                _showDeleteConfirmationDialog(context, transaction);
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

  void _showDeleteConfirmationDialog(
      BuildContext context, TransactionModel transaction) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Delete Transaction"),
          content: const Text(
              "Are you sure you want to delete this transaction record?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final success = await context
                    .read<TransactionProvider>()
                    .deleteTransaction(transaction.id);
                if (mounted) {
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        success
                            ? "Transaction deleted successfully"
                            : "Failed to delete transaction",
                      ),
                      backgroundColor: success ? Colors.green : Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
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
      shape: const RoundedRectangleBorder(
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
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.85,
              child: const Column(
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
