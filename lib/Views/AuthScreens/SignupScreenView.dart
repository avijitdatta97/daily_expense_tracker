import 'package:dec/Views/AuthScreens/LoginScreenView.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    var _outlineInputBorder = OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Radius 10
                        borderSide: BorderSide(
                          color: Color(0xFFD8DADC),
                        ), // Color #D8DADC
                      );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign up",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputLabelText("Email Address"),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Your email",
                          hintStyle: TextStyle(color: Colors.grey),
                          // Standard Border (Fallback)
                          border: _outlineInputBorder,
                          // Enabled Border (State when field is not focused)
                          enabledBorder: _outlineInputBorder,
                          // Focused Border (State when typing - keeping radius consistent)
                          focusedBorder: _outlineInputBorder,
                        ),
                      ),

                      _buildInputLabelText("Name"),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Your name",
                          hintStyle: TextStyle(color: Colors.grey),
                          // Standard Border (Fallback)
                          border: _outlineInputBorder,
                          // Enabled Border (State when field is not focused)
                          enabledBorder: _outlineInputBorder,
                          // Focused Border (State when typing - keeping radius consistent)
                          focusedBorder: _outlineInputBorder,
                        ),
                      ),

                      _buildInputLabelText("Create a Password"),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: _isObscure1,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure1 = !_isObscure1;
                              });
                            },
                            child: _showPasswordText(_isObscure1),
                          ),
                          // Standard Border (Fallback)
                          border: _outlineInputBorder,
                          // Enabled Border (State when field is not focused)
                          enabledBorder: _outlineInputBorder,
                          // Focused Border (State when typing - keeping radius consistent)
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Radius 10
                            borderSide: BorderSide(
                              color: Color(0xFFD8DADC),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      _buildInputLabelText("Confirm Password"),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: _isObscure2,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure2 = !_isObscure2;
                              });
                            },
                            child: _showPasswordText(_isObscure2),
                          ),
                          // Standard Border (Fallback)
                          border: _outlineInputBorder,
                          // Enabled Border (State when field is not focused)
                          enabledBorder: _outlineInputBorder,
                          // Focused Border (State when typing - keeping radius consistent)
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Radius 10
                            borderSide: BorderSide(
                              color: Color(0xFFD8DADC),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),

                  // Signup Button
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                MainScreenView.routeName,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black, // Background color
                              foregroundColor: Colors.white, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ), // Corner radius
                              ),
                              // Optional: Add padding if the button feels too short
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text("Sign in"),
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
                  Text("Already have an account?"),
                  TextButton(onPressed: () {
                    Navigator.pushNamed(context, LogInScreenView.routeName);
                  }, child: Text("Log in")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildInputLabelText(String labelName) {
    return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    labelName,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                );
  }

  Icon _showPasswordText(bool obscureValue) {
    if (obscureValue) {
      return Icon(Icons.visibility_off);
    } else {
      return Icon(Icons.visibility);
    }
  }

}
