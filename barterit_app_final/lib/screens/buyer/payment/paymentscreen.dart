import 'dart:convert';

import 'package:barterit_app_final/models/item.dart';
import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/myconfig.dart';
import 'package:barterit_app_final/screens/buyer/payment/paymentsuccessscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  final Item useritem;
  final double finaltotalPrice; // New parameter
  final int userQuantity; // New parameter
  const PaymentScreen({
    Key? key,
    required this.user,
    required this.finaltotalPrice, // Pass the total price
    required this.userQuantity,
    required this.useritem,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late double screenHeight, screenWidth;
  int value = 0;
  final paymentLabels = [
    'Credit card / Debit card',
    'Cash on delivery',
    'Boost',
    'BarterIt Pay',
  ];
  final paymentIcons = [
    Icons.credit_card,
    Icons.money_off,
    Icons.wallet,
    Icons.account_balance_wallet,
  ];
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromARGB(255, 239, 249, 249),
        elevation: 0.0,
        title: Text(
          "Payment",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),
          Container(
            padding: EdgeInsets.fromLTRB(28, 8, 28, 8),
            child: Text(
              style: TextStyle(
                  fontSize: screenWidth * 0.08, color: Colors.black54),
              'Choose your payment method',
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: paymentLabels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Radio(
                    activeColor: Colors.black,
                    value: index,
                    groupValue: value,
                    onChanged: (i) => setState(() => value = i!),
                  ),
                  title: Text(
                    paymentLabels[index],
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(paymentIcons[index], color: Colors.black),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 5,
                  left: 100,
                  right: 100,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(25.0),
                  // side: BorderSide(color: Colors.black),
                ),
              ),
              onPressed: () {
                // Navigator.of(context).pop();
                processPayment();
                //registerUser();
              },
              child: Text(
                "Pay",
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

  Future<void> processPayment() async {
    String orderpaid = widget.finaltotalPrice.toString();
    String buyerid = widget.user.id.toString();
    String sellerid = widget.useritem.userId.toString();
    String orderlat = widget.useritem.itemLat.toString();
    String orderlng = widget.useritem.itemLong.toString();
    String itemid = widget.useritem.itemId.toString();
    String orderqty = widget.userQuantity.toString();
    http.post(Uri.parse("${MyConfig().SERVER}/barterit_final/php/payment.php"),
        body: {
          "orderpaid": orderpaid,
          "buyerid": buyerid,
          "sellerid": sellerid,
          "orderlat": orderlat,
          "orderlng": orderlng,
          "itemid": itemid,
          "orderqty": orderqty,
        }).then((response) {
      print(response.body);
      print(response.statusCode);

      var jsondata = jsonDecode(response.body);
      print(jsondata);

      //var jsondata= json.decode(json.encode(response.body));

      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("Registration Success")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (content) => PaymentSuccessScreen(
              user: widget.user,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Registration Failed")));
      }

      // if (response.statusCode == 200 && jsondata['status'] == 'success') {
      //   // Payment was successful, and you received a response from the server.
      //   // Process the response as needed.
      //   final responseData = json.decode(response.body);

      // Example handling for success
      //   if (responseData['status'] == 'success') {
      //     // Show a success dialog or navigate to the next screen.
      //     showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           title: Text('Payment Success'),
      //           content: Text('Your payment was successful.'),
      //           actions: <Widget>[
      //             ElevatedButton(
      //               onPressed: () {
      //                 // Close the dialog and navigate to the PaymentSuccessScreen.
      //                 Navigator.pop(context);
      //                 Navigator.pushReplacement(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (content) => PaymentSuccessScreen(
      //                       user: widget.user,
      //                     ),
      //                   ),
      //                 );
      //               },
      //               child: Text('OK'),
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   } else {
      //     // Show an error dialog or handle the payment failure.
      //     showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           title: Text('Payment Failed'),
      //           content: Text('Sorry, your payment failed. Please try again.'),
      //           actions: <Widget>[
      //             ElevatedButton(
      //               onPressed: () {
      //                 // Close the dialog and stay on the current screen.
      //                 Navigator.pop(context);
      //               },
      //               child: Text('OK'),
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   }
      // } else {
      //   // Error occurred in making the payment request to the server.
      //   // Show an error dialog or handle the situation accordingly.
      //   showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: Text('Error'),
      //         content: Text('An error occurred. Please try again later.'),
      //         actions: <Widget>[
      //           ElevatedButton(
      //             onPressed: () {
      //               // Close the dialog and stay on the current screen.
      //               Navigator.pop(context);
      //             },
      //             child: Text('OK'),
      //           ),
      //         ],
      //       );
      //     },
      //   );
    });
  }
}
