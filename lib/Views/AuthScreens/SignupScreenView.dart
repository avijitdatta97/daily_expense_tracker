import 'package:dec/Views/AuthScreens/LoginScreenView.dart';
import 'package:dec/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../MainScreenView.dart';

class SignupScreenView extends StatefulWidget {
  static const String routeName = '/signupPage';
  const SignupScreenView({super.key});

  @override
  State<SignupScreenView> createState() => _SignupScreenViewState();
}

class _SignupScreenViewState extends State<SignupScreenView> {
  bool _isObscure1 = true;
  bool _isObscure2 = true;

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailTextController.dispose();
    _nameTextController.dispose();
    _phoneTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), // Radius 10
      borderSide: const BorderSide(
        color: Color(0xFFD8DADC),
      ), // Color #D8DADC
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputLabelText("Email Address"),
                      TextFormField(
                        controller: _emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Your email",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                      ),

                      _buildInputLabelText("Name"),
                      TextFormField(
                        controller: _nameTextController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Your name",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                      ),

                      _buildInputLabelText("Phone Number"),
                      TextFormField(
                        controller: _phoneTextController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFD8DADC),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }
                          if (value.trim().length == 11) {
                            return "Phone number must be at least 11 characters long";
                          }
                          return null;
                        },
                      ),

                      _buildInputLabelText("Create a Password"),
                      TextFormField(
                        controller: _passwordTextController,
                        keyboardType: TextInputType.text,
                        obscureText: _isObscure1,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure1 = !_isObscure1;
                              });
                            },
                            child: _showPasswordText(_isObscure1),
                          ),
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFD8DADC),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                          return null;
                        },
                      ),

                      _buildInputLabelText("Confirm Password"),
                      TextFormField(
                        controller: _confirmPasswordTextController,
                        keyboardType: TextInputType.text,
                        obscureText: _isObscure2,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure2 = !_isObscure2;
                              });
                            },
                            child: _showPasswordText(_isObscure2),
                          ),
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFD8DADC),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          }
                          if (value != _passwordTextController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),

                      // Signup Button
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: ElevatedButton(
                                onPressed: authProvider.isLoading
                                    ? null
                                    : () async {
                                        if (_formKey.currentState!.validate()) {
                                          final scaffoldMessenger = ScaffoldMessenger.of(context);
                                          final navigator = Navigator.of(context);

                                          final phoneText = _phoneTextController.text.trim();
                                          final success = await authProvider.signup(
                                            name: _nameTextController.text.trim(),
                                            email: _emailTextController.text.trim(),
                                            phone: phoneText.isEmpty ? null : phoneText,
                                            password: _passwordTextController.text,
                                          );

                                          if (!mounted) return;

                                          if (success) {
                                            navigator.pushNamedAndRemoveUntil(
                                              MainScreenView.routeName,
                                              (route) => false,
                                            );
                                          } else {
                                            scaffoldMessenger.showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  authProvider.errorMessage ??
                                                      'Signup failed',
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: authProvider.isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text("Sign up"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LogInScreenView.routeName);
                        },
                        child: const Text("Log in"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildInputLabelText(String labelName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        labelName,
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

  Icon _showPasswordText(bool obscureValue) {
    if (obscureValue) {
      return const Icon(Icons.visibility_off);
    } else {
      return const Icon(Icons.visibility);
    }
  }
}
