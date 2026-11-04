import 'package:dec/Views/AuthScreens/PhoneVerificationScreenView.dart';
import 'package:dec/Views/AuthScreens/SignupScreenView.dart';
import 'package:dec/Views/MainScreenView.dart';
import 'package:dec/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LogInScreenView extends StatefulWidget {
  static const String routeName = '/loginPage';

  const LogInScreenView({super.key});

  @override
  State<LogInScreenView> createState() => _LogInScreenViewState();
}

class _LogInScreenViewState extends State<LogInScreenView> {
  bool _isObscure = true;

  final TextEditingController _emailTextEditorController = TextEditingController();
  final TextEditingController _passwordTextEditorController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailTextEditorController.dispose();
    _passwordTextEditorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "Email address",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: _emailTextEditorController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Your email",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFD8DADC),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFD8DADC),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFD8DADC),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return "Please Enter Valid Email Address";
                          }
                          return null;
                        },
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "Password",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: _passwordTextEditorController,
                        keyboardType: TextInputType.text,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            child: _showPasswordText(),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFD8DADC),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFD8DADC),
                            ),
                          ),
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
                            return "Please Enter Password";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                // Forget Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PhoneVerificationScreenView.routeName);
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Login Button
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                                  final navigator = Navigator.of(context);

                                  final success = await authProvider.login(
                                    _emailTextEditorController.text.trim(),
                                    _passwordTextEditorController.text,
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
                                              'Login failed',
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
                            : const Text("Log in"),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ColoredBox(
                          color: Colors.grey,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 3.2,
                            height: 1,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Or Login with",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ColoredBox(
                          color: Colors.grey,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 3.2,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: _buildExtraLogInMethod(
                            "images/facebook_icon.svg", Colors.blue)),
                    const SizedBox(height: 10),
                    Expanded(
                        child: _buildExtraLogInMethod(
                            "images/google_icon.svg", Colors.redAccent)),
                    const SizedBox(height: 10),
                    Expanded(
                        child: _buildExtraLogInMethod(
                            "images/apple_icon.svg", Colors.black)),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, SignupScreenView.routeName);
                        },
                        child: const Text("Sign up"),
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

  Card _buildExtraLogInMethod(String iconName, Color colorName) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color:Colors.grey.shade300, width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 38.0),
        child: SvgPicture.asset(
          iconName,
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  Icon _showPasswordText() {
    if (_isObscure) {
      return const Icon(Icons.visibility_off);
    } else {
      return const Icon(Icons.visibility);
    }
  }
}
