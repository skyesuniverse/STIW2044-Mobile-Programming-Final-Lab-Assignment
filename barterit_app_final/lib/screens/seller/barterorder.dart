import 'dart:convert';

import 'package:barterit_app_final/models/order.dart';
import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/myconfig.dart';
import 'package:barterit_app_final/screens/seller/barterorderdetailsscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BarterOrderScreen extends StatefulWidget {
  final User user;
  const BarterOrderScreen({super.key, required this.user});

  @override
  State<BarterOrderScreen> createState() => _BarterOrderScreenState();
}

class _BarterOrderScreenState extends State<BarterOrderScreen> {
  String status = "Loading...";
  List<Order> orderList = <Order>[];
  late double screenHeight, screenWidth, cardwitdh;

  @override
  void initState() {
    super.initState();
    loadbarterorders();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Barter Orders")),
      body: Container(
        child: orderList.isEmpty
            ? Center(
                child: Text("Currently do no have any order..."),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 15, 8),
                          child: Text(
                            "My Current Barter Orders (${orderList.length})",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(),
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
                                            BarterOrderDetailsScreen(
                                              order: myorder,
                                            )));
                                loadbarterorders();
                              },
                              leading: CircleAvatar(
                                  radius: 16,
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

  void loadbarterorders() {
    http.post(
        Uri.parse(
            "${MyConfig().SERVER}/barterit_final/php/load_barterorder.php"),
        body: {"sellerid": widget.user.id}).then((response) {
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

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Barter Order loaded fail")));
        }
        setState(() {});
      }
    });
  }
}
