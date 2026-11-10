import 'package:dec/models/account_type.dart';
import 'package:dec/models/category_model.dart';
import 'package:dec/providers/category_provider.dart';
import 'package:dec/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionForm extends StatefulWidget {
  final String type;

  const TransactionForm({super.key, required this.type});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  CategoryModel? _selectedCategory;
  SubcategoryModel? _selectedSubCategory;
  AccountType? _selectedAccountType;

  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final transactionProvider = context.read<TransactionProvider>();
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      final now = DateTime.now();
      final dateStr =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      final timeStr =
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

      final success = await transactionProvider.createTransaction(
        type: widget.type.toUpperCase(),
        amount: double.parse(_amountController.text.trim()),
        categoryId: _selectedCategory!.id,
        subcategoryId: _selectedSubCategory!.id,
        account: _selectedAccountType!.apiValue,
        transactionDate: dateStr,
        transactionTime: timeStr,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text("${widget.type} transaction saved successfully!"),
            backgroundColor: Colors.green,
          ),
        );
        navigator.pop(); // close bottom sheet
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              transactionProvider.errorMessage ?? 'Failed to save transaction',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
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
    final categoryProvider = context.watch<CategoryProvider>();
    final transactionProvider = context.watch<TransactionProvider>();

    final categories = categoryProvider.getCategoriesByType(widget.type);
    final subcategories = _selectedCategory?.subcategories ?? [];

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
            DropdownButtonFormField<CategoryModel>(
              value: _selectedCategory,
              decoration: InputDecoration(
                hintText: categoryProvider.isLoading
                    ? "Loading categories..."
                    : "Select Category",
                hintStyle: const TextStyle(color: Colors.grey),
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
              ),
              items: categories.map((CategoryModel category) {
                return DropdownMenuItem<CategoryModel>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (CategoryModel? value) {
                setState(() {
                  _selectedCategory = value;
                  _selectedSubCategory = null;
                });
              },
              validator: (value) {
                if (value == null) {
                  return "Please select a category";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            /// Sub-Category Dropdown
            _buildInputLabelText("Sub-Category"),
            DropdownButtonFormField<SubcategoryModel>(
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
              items: subcategories.map((SubcategoryModel subCategory) {
                return DropdownMenuItem<SubcategoryModel>(
                  value: subCategory,
                  child: Text(subCategory.name),
                );
              }).toList(),
              onChanged: _selectedCategory == null
                  ? null
                  : (SubcategoryModel? value) {
                      setState(() {
                        _selectedSubCategory = value;
                      });
                    },
              validator: (value) {
                if (value == null) {
                  return "Please select a sub-category";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            /// Account Type Dropdown
            _buildInputLabelText("Account Type"),
            DropdownButtonFormField<AccountType>(
              value: _selectedAccountType,
              decoration: InputDecoration(
                hintText: "Select Account Type",
                hintStyle: const TextStyle(color: Colors.grey),
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
              ),
              items: AccountType.values.map((AccountType type) {
                return DropdownMenuItem<AccountType>(
                  value: type,
                  child: Text(type.displayName),
                );
              }).toList(),
              onChanged: (AccountType? value) {
                setState(() {
                  _selectedAccountType = value;
                });
              },
              validator: (value) {
                if (value == null) {
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
                    onPressed: transactionProvider.isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: transactionProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text("Save ${widget.type}"),
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
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
