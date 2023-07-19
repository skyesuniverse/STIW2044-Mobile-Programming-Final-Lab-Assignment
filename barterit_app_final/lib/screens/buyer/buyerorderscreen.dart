import 'dart:convert';
import 'dart:developer';
import 'package:barterit_app_final/models/order.dart';
import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/myconfig.dart';
import 'package:barterit_app_final/screens/buyer/buyerorderdetailsscreen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class BuyerOrderScreen extends StatefulWidget {
  final User user;
  const BuyerOrderScreen({super.key, required this.user});

  @override
  State<BuyerOrderScreen> createState() => _BuyerOrderScreenState();
}

class _BuyerOrderScreenState extends State<BuyerOrderScreen> {
  late double screenHeight, screenWidth, cardwitdh;

  String status = "Loading...";
  List<Order> orderList = <Order>[];
  @override
  void initState() {
    super.initState();
    loadbuyerorders();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: Container(
        child: orderList.isEmpty
            ? Center(
                child: Text("Currently do no have any order..."),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   width: screenWidth,
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                  //     child: Row(
                  //       children: [
                  //         Flexible(
                  //             flex: 7,
                  //             child: Row(
                  //               children: [
                  //                 const CircleAvatar(
                  //                   backgroundImage: AssetImage(
                  //                     "assets/images/profile.png",
                  //                   ),
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 8,
                  //                 ),
                  //                 Text(
                  //                   "Hello ${widget.user.name}!",
                  //                   style: const TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.bold),
                  //                 ),
                  //               ],
                  //             )),
                  //         Expanded(
                  //           flex: 3,
                  //           child: Row(children: [
                  //             IconButton(
                  //               icon: const Icon(Icons.notifications),
                  //               onPressed: () {},
                  //             ),
                  //             IconButton(
                  //               icon: const Icon(Icons.search),
                  //               onPressed: () {},
                  //             ),
                  //           ]),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 15, 8),
                          child: Text(
                            "Your Current Order/s (${orderList.length})",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(),
                        // IconButton(
                        //   icon: const Icon(Icons.menu),
                        //   onPressed: () {},
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: orderList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                Order myorder =
                                    Order.fromJson(orderList[index].toJson());
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            BuyerOrderDetailsScreen(
                                              order: myorder,
                                            )));
                                loadbuyerorders();
                              },
                              leading: CircleAvatar(
                                  child: Text((index + 1).toString())),
                              title: Text(
                                  "Receipt: ${orderList[index].orderBill}"),
                              trailing: const Icon(Icons.arrow_forward),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Order ID: ${orderList[index].orderId}"),
                                        Text(
                                            "Status: ${orderList[index].orderStatus}")
                                      ]),
                                  Column(
                                    children: [
                                      Text(
                                        "RM ${double.parse(orderList[index].orderPaid.toString()).toStringAsFixed(2)}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text("")
                                    ],
                                  )
                                ],
                              ),
                            );
                          })),
                ],
              ),
      ),
    );
  }

  
  void loadbuyerorders() {
    http.post(
        Uri.parse(
            "${MyConfig().SERVER}/barterit_final/php/load_buyerorder.php"),
        body: {"buyerid": widget.user.id}).then((response) {
      print(response.body);
      print(response.statusCode);
      // log(response.body);
      //orderList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          orderList.clear();
          var extractdata = jsondata['data'];
          extractdata['orders'].forEach((v) {
            orderList.add(Order.fromJson(v));
          });
        } else {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("No order found")));
        }
        setState(() {});
      }
    });
  }
}
