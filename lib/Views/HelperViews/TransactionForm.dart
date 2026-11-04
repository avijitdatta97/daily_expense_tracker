import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final String type;

  const TransactionForm({super.key, required this.type});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCategory;
  String? _selectedSubCategory;
  String? _selectedAccountType;

  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  final Map<String, List<String>> _incomeCategoriesWithSub = {
    'Salary': ['Monthly Salary', 'Bonus', 'Overtime'],
    'Business': ['Sales', 'Services', 'Profit'],
    'Investment': ['Dividends', 'Interest', 'Stocks'],
    'Freelance': ['Project', 'Consulting'],
    'Other Income': ['Gift', 'Refund', 'Miscellaneous'],
  };

  final Map<String, List<String>> _expenseCategoriesWithSub = {
    'Food & Dining': ['Groceries', 'Restaurants', 'Fast Food', 'Coffee'],
    'Bills & Utilities': ['Electricity', 'Water', 'Internet', 'Rent'],
    'Shopping': ['Clothing', 'Electronics', 'Home Items'],
    'Transportation': ['Fuel', 'Public Transit', 'Taxi/Uber'],
    'Entertainment': ['Movies', 'Games', 'Subscriptions'],
    'Health & Medical': ['Medicines', 'Doctor Visit', 'Hospital'],
    'Other Expense': ['Miscellaneous', 'Personal Care'],
  };

  final List<String> _accountTypes = [
    'Cash',
    'Bank Account',
    'Credit Card',
    'Mobile Wallet',
    'Savings Account',
  ];

  Map<String, List<String>> get _categoryMap =>
      widget.type == 'Income' ? _incomeCategoriesWithSub : _expenseCategoriesWithSub;

  List<String> get _currentSubCategories {
    if (_selectedCategory == null) return [];
    return _categoryMap[_selectedCategory] ?? ['General'];
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final category = _selectedCategory;
      final subCategory = _selectedSubCategory;
      final accountType = _selectedAccountType;
      final amount = double.parse(_amountController.text.trim());
      final note = _noteController.text.trim();

      debugPrint("Type: ${widget.type}");
      debugPrint("Category: $category");
      debugPrint("SubCategory: $subCategory");
      debugPrint("AccountType: $accountType");
      debugPrint("Amount: $amount");
      debugPrint("Note: $note");

      Navigator.pop(context); // close bottom sheet
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Color(0xFFD8DADC),
      ),
    );

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Category Dropdown
            _buildInputLabelText("Category"),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                hintText: "Select Category",
                hintStyle: const TextStyle(color: Colors.grey),
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
              ),
              items: _categoryMap.keys.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                  _selectedSubCategory = null;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a category";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            /// Sub-Category Dropdown
            _buildInputLabelText("Sub-Category"),
            DropdownButtonFormField<String>(
              value: _selectedSubCategory,
              decoration: InputDecoration(
                hintText: _selectedCategory == null
                    ? "Select Category first"
                    : "Select Sub-Category",
                hintStyle: const TextStyle(color: Colors.grey),
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
              ),
              items: _currentSubCategories.map((String subCategory) {
                return DropdownMenuItem<String>(
                  value: subCategory,
                  child: Text(subCategory),
                );
              }).toList(),
              onChanged: _selectedCategory == null
                  ? null
                  : (value) {
                      setState(() {
                        _selectedSubCategory = value;
                      });
                    },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a sub-category";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            /// Account Type Dropdown
            _buildInputLabelText("Account Type"),
            DropdownButtonFormField<String>(
              value: _selectedAccountType,
              decoration: InputDecoration(
                hintText: "Select Account Type",
                hintStyle: const TextStyle(color: Colors.grey),
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
              ),
              items: _accountTypes.map((String accountType) {
                return DropdownMenuItem<String>(
                  value: accountType,
                  child: Text(accountType),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAccountType = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select an account type";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            /// Amount
            _buildInputLabelText("Amount"),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: "Enter amount",
                hintStyle: const TextStyle(color: Colors.grey),
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter amount";
                }
                if (double.tryParse(value.trim()) == null) {
                  return "Enter a valid amount";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            /// Note
            _buildInputLabelText("Note"),
            TextFormField(
              controller: _noteController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: "Enter note",
                hintStyle: const TextStyle(color: Colors.grey),
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
              ),
            ),
            const SizedBox(height: 20),

            /// Save Button
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text("Save ${widget.type}"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabelText(String labelName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        labelName,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }
}