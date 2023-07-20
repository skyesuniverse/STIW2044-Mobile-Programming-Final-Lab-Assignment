import 'dart:convert';
import 'dart:developer';

import 'package:barterit_app_final/models/order.dart';
import 'package:barterit_app_final/models/orderdetails.dart';
import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/myconfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BuyerOrderDetailsScreen extends StatefulWidget {
  final Order order;
  const BuyerOrderDetailsScreen({super.key, required this.order});

  @override
  State<BuyerOrderDetailsScreen> createState() =>
      _BuyerOrderDetailsScreenState();
}

class _BuyerOrderDetailsScreenState extends State<BuyerOrderDetailsScreen> {
  List<OrderDetails> orderdetailsList = <OrderDetails>[];
  late double screenHeight, screenWidth;
  String selectStatus = "Ready";
  // Set<Marker> markers = {};
  var pathAsset = "assets/images/profile.png";
  List<String> statusList = [
    "New",
    "Processing",
    "Ready",
    "Completed",
  ];
  late User user = User(
      id: "na",
      name: "na",
      email: "na",
      datereg: "na",
      password: "na",
      otp: "na");
  // var pickupLatLng;
  // String picuploc = "Not selected";
  // var _pickupPosition;

  @override
  void initState() {
    super.initState();
    loadbuyer();
    loadorderdetails();
    //selectStatus = widget.order.orderStatus.toString();
    // if (widget.order.orderLat.toString() == "") {
    //   picuploc = "Not selected";
    //   _pickupPosition = const CameraPosition(
    //     target: LatLng(6.4301523, 100.4287586),
    //     zoom: 12.4746,
    //   );
    // } else {
    //   picuploc = "Selected";
    //   pickupLatLng = LatLng(double.parse(widget.order.orderLat.toString()),
    //       double.parse(widget.order.orderLng.toString()));
    //   _pickupPosition = CameraPosition(
    //     target: pickupLatLng,
    //     zoom: 18.4746,
    //   );
    //   MarkerId markerId1 = const MarkerId("1");
    //   markers.clear();
    //   markers.add(Marker(
    //     markerId: markerId1,
    //     position: pickupLatLng,
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    //   ));
    // }
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                // Container(
                //   margin: const EdgeInsets.all(4),
                //   width: screenWidth * 0.2,
                //   child: CircleAvatar(
                //     radius: screenWidth * 0.1,
                //     child: ClipOval(
                //       child: CachedNetworkImage(
                //         imageUrl:
                //             "${MyConfig().SERVER}/barterit_final/assets/profileimages/${widget.order.buyerId}.png?",
                //         placeholder: (context, url) => Image.asset(
                //           pathAsset,
                //           fit: BoxFit.contain,
                //         ),
                //         errorWidget: (context, url, error) => Image.network(
                //           "${MyConfig().SERVER}/barterit_final/assets/profileimages/0.png",
                //           scale: 2,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
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
                      user.id == "na"
                          ? const Center(
                              child: Text("Loading..."),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Buyer name: ${user.name}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text("Order ID: ${widget.order.orderId}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    )),
                                SizedBox(height: 4),
                                Text(
                                  "Total Paid: RM ${double.parse(widget.order.orderPaid.toString()).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text("Status: ${widget.order.orderStatus}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    )),
                                SizedBox(height: 4),
                                Text(
                                  "Delivery Address: ${user.address}",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            )
                    ],
                  ),
                )
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
                          child: Row(children: [
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderdetailsList[index].itemName.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Quantity: ${orderdetailsList[index].orderQty}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Paid: RM ${double.parse(orderdetailsList[index].orderPaid.toString()).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                      );
                    }),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.09),
              child: SizedBox(
                // color: Colors.red,
                width: screenWidth,
                height: screenHeight * 0.1,
                child: Card(
                  color: Color.fromARGB(255, 231, 253, 247),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Set order status as completed",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                        // DropdownButton(
                        //   itemHeight: 60,
                        //   value: selectStatus,
                        //   onChanged: (newValue) {
                        //     setState(() {
                        //       selectStatus = newValue.toString();
                        //     });
                        //   },
                        //   items: statusList.map((selectStatus) {
                        //     return DropdownMenuItem(
                        //       value: selectStatus,
                        //       child: Text(
                        //         selectStatus,
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),
                        ElevatedButton(
                            onPressed: () {
                              submitStatus("Completed");
                            },
                            child: const Text("Submit"))
                      ]),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void loadorderdetails() {
    http.post(
        Uri.parse(
            "${MyConfig().SERVER}/barterit_final/php/load_buyerorderdetails.php"),
        body: {
          "buyerid": widget.order.buyerId,
          "orderbill": widget.order.orderBill,
          "sellerid": widget.order.sellerId
        }).then((response) {
      // log(response.body);
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
      log(response.body);
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
        body: {"orderid": widget.order.orderId, "status": st}).then((response) {
      log(response.body);
      //orderList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
        } else {}
        widget.order.orderStatus = st;
        selectStatus = st;
        setState(() {});
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Successfully update")));
      }
    });
  }
}
