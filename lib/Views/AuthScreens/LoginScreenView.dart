import 'package:dec/Views/AuthScreens/PhoneVerificationScreenView.dart';
import 'package:dec/Views/AuthScreens/SignupScreenView.dart';
import 'package:dec/Views/MainScreenView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogInScreenView extends StatefulWidget {
  static const String routeName = '/loginPage';

  const LogInScreenView({super.key});

  @override
  State<LogInScreenView> createState() => _LogInScreenViewState();
}

class _LogInScreenViewState extends State<LogInScreenView> {
  bool _isObscure = true;

  TextEditingController _emailTextEditorController = TextEditingController();
  TextEditingController _passwordTextEditorController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
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
                        controller: _emailTextEditorController,
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
                        validator: (value){
                          if (value == null || value.isEmpty){
                            return "Please Enter Email Address";
                          }
                          return null;
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                        validator: (value){
                          if (value == null || value.isEmpty){
                            return "Please Enter Password (hint: 123456)";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
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

                SizedBox(
                  height: 10,
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
                        child: Text("Log in"),
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
                    Expanded(child: _buildExtraLogInMethod("images/facebook_icon.svg", Colors.blue)),
                    SizedBox(height: 10,),
                    Expanded(child: _buildExtraLogInMethod("images/google_icon.svg", Colors.redAccent)),
                    SizedBox(height: 10,),
                    Expanded(child: _buildExtraLogInMethod("images/apple_icon.svg", Colors.black)),
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

  void _authenticate() async{
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: "Please wait...", dismissOnTap: false);

      final _email = _emailTextEditorController.text;
      final _password = _passwordTextEditorController.text;

      try{
        // final status = await
      } on FirebaseAuthException catch(error){

      }
    }
  }
}
