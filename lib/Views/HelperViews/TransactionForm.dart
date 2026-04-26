import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final String type;

  const TransactionForm({required this.type});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final amount = double.parse(_amountController.text.trim());
      final description = _descriptionController.text.trim();

      print("Type: ${widget.type}");
      print("Title: $title");
      print("Amount: $amount");
      print("Description: $description");

      Navigator.pop(context); // close bottom sheet
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), // Radius 10
      borderSide: BorderSide(
        color: Color(0xFFD8DADC),
      ), // Color #D8DADC
    );
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// Title
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Your name",
                hintStyle: TextStyle(color: Colors.grey),
                border: _outlineInputBorder,
                enabledBorder: _outlineInputBorder,
                focusedBorder: _outlineInputBorder,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter a title";
                }
                return null;
              },
            ),
            SizedBox(height: 10),

            /// Amount
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Amount",
                hintStyle: TextStyle(color: Colors.grey),
                border: _outlineInputBorder,
                enabledBorder: _outlineInputBorder,
                focusedBorder: _outlineInputBorder,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter amount";
                }
                if (double.tryParse(value) == null) {
                  return "Enter a valid number";
                }
                return null;
              },
            ),
            SizedBox(height: 10),

            /// Description
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: "Description",
                hintStyle: TextStyle(color: Colors.grey),
                border: _outlineInputBorder,
                enabledBorder: _outlineInputBorder,
                focusedBorder: _outlineInputBorder,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter description";
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            /// Save Button
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _submit;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Background color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Corner radius
                      ),
                      // Optional: Add padding if the button feels too short
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
}