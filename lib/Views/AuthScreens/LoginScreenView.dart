import 'package:dec/Views/AuthScreens/PhoneVerificationScreenView.dart';
import 'package:dec/Views/AuthScreens/SignupScreenView.dart';
import 'package:dec/Views/MainScreenView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogInScreenView extends StatefulWidget {
  static const String routeName = '/loginPage';

  const LogInScreenView({super.key});

  @override
  State<LogInScreenView> createState() => _LogInScreenViewState();
}

class _LogInScreenViewState extends State<LogInScreenView> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Log in",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Email address",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Your email",
                      hintStyle: TextStyle(color: Colors.grey),
                      // Standard Border (Fallback)
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Radius 10
                        borderSide: BorderSide(
                          color: Color(0xFFD8DADC),
                        ), // Color #D8DADC
                      ),
                      // Enabled Border (State when field is not focused)
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Radius 10
                        borderSide: BorderSide(
                          color: Color(0xFFD8DADC),
                        ), // Color #D8DADC
                      ),
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

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Password",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        child: _showPasswordText(),
                      ),
                      // Standard Border (Fallback)
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Radius 10
                        borderSide: BorderSide(
                          color: Color(0xFFD8DADC),
                        ), // Color #D8DADC
                      ),
                      // Enabled Border (State when field is not focused)
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Radius 10
                        borderSide: BorderSide(
                          color: Color(0xFFD8DADC),
                        ), // Color #D8DADC
                      ),
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
              ),
            ),

            // Forget Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PhoneVerificationScreenView.routeName);
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ],
            ),

            // Login Button
            Row(
              children: [
                Expanded(
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
                    child: Text("Log in"),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                _buildExtraLogInMethod("images/facebook_icon.svg", Colors.blue),
                _buildExtraLogInMethod("images/google_icon.svg", Colors.redAccent),
                _buildExtraLogInMethod("images/apple_icon.svg", Colors.black),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(onPressed: () {
                    Navigator.pushNamed(context, SignupScreenView.routeName);
                  }, child: Text("Sign up")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildExtraLogInMethod(String iconName, Color colorName) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 38.0),
        child: SvgPicture.asset(iconName, width: 30, height: 30,),
      ),
    );
  }

  Icon _showPasswordText() {
    if (_isObscure) {
      return Icon(Icons.visibility_off);
    } else {
      return Icon(Icons.visibility);
    }
  }
}
