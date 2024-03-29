import 'dart:convert';
import 'dart:developer';
import 'package:barterit_app_final/models/item.dart';
import 'package:barterit_app_final/models/orderdetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:barterit_app_final/models/order.dart';
import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/myconfig.dart';
import 'package:flutter/material.dart';

class BarterOrderDetailsScreen extends StatefulWidget {
  final Order order;
  const BarterOrderDetailsScreen({super.key, required this.order});

  @override
  State<BarterOrderDetailsScreen> createState() =>
      _BarterOrderDetailsScreenState();
}

class _BarterOrderDetailsScreenState extends State<BarterOrderDetailsScreen> {
  late bool hasProfileImage = false;
  var pathAsset = "assets/images/profile.png";
  List<OrderDetails> orderdetailsList = <OrderDetails>[];
  late double screenHeight, screenWidth;
  String selectStatus = "New";
  // ignore: prefer_typing_uninitialized_variables
  var pickupLatLng;
  List<String> statusList = ["New", "Processing", "Ready", "Completed"];
  late User user = User(
      id: "na",
      name: "na",
      email: "na",
      datereg: "na",
      password: "na",
      otp: "na");
  late Item useritem = Item(
      itemId: "na",
      userId: "na",
      itemName: "na",
      itemCategory: "na",
      itemDesc: "na",
      itemPrice: "na",
      itemQty: "na",
      itemLat: "na",
      itemLong: "na",
      itemState: "na",
      itemLocality: "na",
      itemDate: "na");

  String picuploc = "Not selected";

  @override
  void initState() {
    super.initState();
    loadbuyer();
    loaditem();
    loadorderdetails();
    selectStatus = widget.order.orderStatus.toString();
    if (widget.order.orderLat.toString() == "") {
      picuploc = "Not selected";
    } else {
      picuploc = "Selected";
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: CachedNetworkImageProvider(
                      "${MyConfig().SERVER}/barterit_final/assets/profileimages/${widget.order.buyerId}.png?",
                    ),
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Buyer name: ${user.name}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Order ID: ${widget.order.orderId}",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Total Paid: RM ${double.parse(widget.order.orderPaid.toString()).toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Status: ${widget.order.orderStatus}",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Delivery Address: ${user.address}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.08),
              Text(
                "Item Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              orderdetailsList.isEmpty
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: orderdetailsList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${MyConfig().SERVER}/barterit_final/assets/items/${orderdetailsList[index].itemId}_${0 + 1}.png",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        orderdetailsList[index]
                                            .itemName
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Quantity: ${orderdetailsList[index].orderQty}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Paid: RM ${double.parse(orderdetailsList[index].orderPaid.toString()).toStringAsFixed(2)}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.2,
                child: Card(
                  color: Color.fromARGB(255, 231, 253, 247),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                "Set Order Status",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w800),
                              ),
                            ),
                            Container(
                              height: screenHeight *
                                  0.085, // Set a fixed height for the dropdown container
                              child: DropdownButton(
                                itemHeight: 50,
                                value: selectStatus,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectStatus = newValue.toString();
                                  });
                                },
                                items: statusList.map((selectStatus) {
                                  return DropdownMenuItem(
                                    value: selectStatus,
                                    child: Text(
                                      selectStatus,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          submitStatus(selectStatus);
                        },
                        child: const Text("Submit"),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loadorderdetails() {
    http.post(
        Uri.parse(
            "${MyConfig().SERVER}/barterit_final/php/load_barterorderdetails.php"),
        body: {
          "sellerid": widget.order.sellerId,
          "orderbill": widget.order.orderBill
        }).then((response) {
      print(response.statusCode);
      print(response.body);
      log(response.body);
      //orderList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['orderdetails'].forEach((v) {
            orderdetailsList.add(OrderDetails.fromJson(v));
          });
        } else {
          // status = "Please register an account first";
          // setState(() {});
        }
        setState(() {});
      }
    });
  }

  void loadbuyer() {
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_final/php/load_user.php"),
        body: {
          "userid": widget.order.buyerId,
        }).then((response) {
      // log(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          user = User.fromJson(jsondata['data']);
        }
      }
      setState(() {});
    });
  }

  void submitStatus(String st) {
    http.post(
        Uri.parse(
            "${MyConfig().SERVER}/barterit_final/php/set_orderstatus.php"),
        body: {
          "orderid": widget.order.orderId,
          "status": st,
        }).then((response) {
      log(response.body);
      //orderList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
        } else {}
        widget.order.orderStatus = st;
        selectStatus = st;
        setState(() {});
      }
    });
  }

  void loaditem() {
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_final/php/load_item.php"),
        body: {
          "itemid": widget.order.itemId,
        }).then((response) {
      // log(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          useritem = Item.fromJson(jsondata['data']);
          print(useritem);
        }
      }
      setState(() {});
    });
  }
}
