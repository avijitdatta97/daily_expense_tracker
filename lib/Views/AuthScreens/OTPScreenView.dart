import 'package:dec/Views/HelperWidget/AuthScreenHeader.dart';
import 'package:dec/Views/MainScreenView.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPScreenView extends StatefulWidget {
  static const String routeName = '/otpPage';
  const OTPScreenView({super.key});

  @override
  State<OTPScreenView> createState() => _OTPScreenViewState();
}

class _OTPScreenViewState extends State<OTPScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthScreenHeader(headerText: 'Enter Code'),
            Text(
              "We've sent asn SMS with an activation code to your phone +8801XX-XXXXXXX.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Form(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pinput(
                    focusedPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
                        borderRadius: BorderRadius.circular(8)
                      ),
                    ),
                    errorPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(255, 0, 0, 1)),
                          borderRadius: BorderRadius.circular(8)
                      ),
                    ),
                    validator: (s){
                      return s == '1234' ? null : 'Pin is incorrect';
                    },
                  )
                ],
              )),
            ),

            SizedBox(height: 30,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MainScreenView.routeName);
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
                    child: Text("Verify"),
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
