import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/screens/buyer/billscreen.dart';
import 'package:barterit_app_final/screens/shared/mainscreen.dart';
import 'package:barterit_app_final/screens/shared/profiletabscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final User user;
  const PaymentSuccessScreen({super.key, required this.user});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  late double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/success.gif'),
              height: 150.0,
            ),
            Text(
              'Successful',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.04),
            Text('Your payment was done successfully'),
            SizedBox(height: screenHeight * 0.08),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 5,
                    left: 120,
                    right: 120,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(25.0),
                    // side: BorderSide(color: Colors.black),
                  ),
                ),
                onPressed: () async {
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (content) => MainScreen(
                        user: widget.user,
                        // finaltotalprice: finaltotalprice,
                      ),
                    ),
                    (route) =>
                        false, // Remove all previous routes from the stack
                  );
                },
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
