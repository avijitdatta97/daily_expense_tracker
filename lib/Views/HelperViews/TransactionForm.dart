import 'package:dec/models/account_type.dart';
import 'package:dec/models/category_model.dart';
import 'package:dec/providers/category_provider.dart';
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final categoryId = _selectedCategory?.id;
      final categoryName = _selectedCategory?.name;
      final subcategoryId = _selectedSubCategory?.id;
      final subcategoryName = _selectedSubCategory?.name;
      final accountType = _selectedAccountType?.apiValue;
      final amount = double.parse(_amountController.text.trim());
      final note = _noteController.text.trim();

      debugPrint("Type: ${widget.type}");
      debugPrint("CategoryId: $categoryId, CategoryName: $categoryName");
      debugPrint("SubcategoryId: $subcategoryId, SubcategoryName: $subcategoryName");
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
    final categoryProvider = context.watch<CategoryProvider>();
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
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
