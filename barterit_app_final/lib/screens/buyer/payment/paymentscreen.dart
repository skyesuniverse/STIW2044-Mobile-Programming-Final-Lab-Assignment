import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/screens/buyer/payment/paymentsuccessscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  const PaymentScreen({super.key, required this.user});

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
              onPressed: () async {
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => PaymentSuccessScreen(
                              user: widget.user,
                              // finaltotalprice: finaltotalprice,
                            )));
              },
              child: Text(
                "Pay",
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
