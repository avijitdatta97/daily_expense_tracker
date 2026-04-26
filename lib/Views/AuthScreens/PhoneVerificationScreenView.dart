import 'package:dec/Views/AuthScreens/OTPScreenView.dart';
import 'package:flutter/material.dart';

import '../HelperWidget/AuthScreenHeader.dart';

class PhoneVerificationScreenView extends StatefulWidget {
  static const String routeName = '/phoneVerificationPage';

  const PhoneVerificationScreenView({super.key});

  @override
  State<PhoneVerificationScreenView> createState() =>
      _PhoneVerificationScreenViewState();
}

class _PhoneVerificationScreenViewState
    extends State<PhoneVerificationScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthScreenHeader(headerText: 'Enter Code',),

                Text(
                  "Please enter your phone number.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),

                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "Phone Number",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "01XXXXXXXXX",
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

                      SizedBox(height: 30),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, OTPScreenView.routeName);
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
                              child: Text("Continue"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}