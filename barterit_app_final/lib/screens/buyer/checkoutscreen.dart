import 'dart:convert';
import 'dart:io';
import 'package:barterit_app_final/models/item.dart';
import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/myconfig.dart';
import 'package:barterit_app_final/screens/buyer/billscreen.dart';
import 'package:barterit_app_final/screens/buyer/payment/paymentscreen.dart';
import 'package:barterit_app_final/screens/shared/profiletabscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckOutScreen extends StatefulWidget {
  final Item useritem;
  final User user;
  final double totalPrice; // New parameter
  final int userQuantity; // New parameter
  const CheckOutScreen({
    Key? key,
    required this.useritem,
    required this.user,
    required this.totalPrice, // Pass the total price
    required int page,
    required this.userQuantity, // Pass the user quantity
  }) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final TextEditingController _addressController = TextEditingController();
  late double screenHeight, screenWidth, cardwitdh;
  List<File?> selectedImages = [null, null, null];

  @override
  void initState() {
    super.initState();
    qty = int.parse(widget.useritem.itemQty.toString());
    totalprice = double.parse(widget.useritem.itemPrice.toString());
    singleprice = double.parse(widget.useritem.itemPrice.toString());
    finaltotalprice = widget.totalPrice + shippingfee;
    userqty = widget.userQuantity;
  }

  int qty = 0;
  int userqty = 1;
  double totalprice = 0.0;
  double singleprice = 0.0;
  double shippingfee = 5.0;
  double finaltotalprice = 0.0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        //////////////////////more form this seller
        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => ProfileTabScreen(
                            user: widget.user,
                            // useritem: widget.usercatch,
                          )));
            },
            icon: const Icon(Icons.more_horiz_outlined),
            tooltip: "More from this seller",
          )
        ],
        toolbarHeight: 50,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromARGB(255, 239, 249, 249),
        elevation: 0.0,
        title: Text(
          "Check Out",
          style: TextStyle(color: Colors.black),
        ),
        // centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 239, 249, 249),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  height: screenHeight * 0.455,
                  width: screenWidth,
                  child: Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4),
                            width: screenWidth * 0.55,
                            child: CachedNetworkImage(
                                imageUrl:
                                    "${MyConfig().SERVER}/barterit_final/assets/items/${widget.useritem.itemId}_${0 + 1}.png",
                                placeholder: (context, url) =>
                                    const LinearProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.network(
                                      "${MyConfig().SERVER}/mynelayan/assets/profile/0.png",
                                      scale: 2,
                                    )),
                          ),
                          Expanded(
                            flex: 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 8),
                                      child: Text(
                                        widget.useritem.itemName.toString(),
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    ),
                                    // const Divider(),
                                    Text(widget.useritem.itemCategory
                                        .toString()),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 8, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.grey,
                                            size: 19,
                                          ),
                                          SizedBox(width: 5),
                                          Flexible(
                                            child: Text(
                                              widget.useritem.itemLocality
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 25),
                                          Icon(
                                            Icons.flag_sharp,
                                            color: Colors.grey,
                                            size: 19,
                                          ),
                                          SizedBox(width: 5),
                                          Flexible(
                                            child: Text(
                                              widget.useritem.itemState
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Text(df.format(DateTime.parse(
                                    //     widget.user.datereg.toString()))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Price Breakdown',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 6, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Base Price',
                        // style: AppTheme.of(context).subtitle2,
                      ),
                      Text(
                        "RM ${double.parse(widget.useritem.itemPrice.toString()).toStringAsFixed(2)}",
                        // style: AppTheme.of(context).subtitle1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 6, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        // style: AppTheme.of(context).subtitle2,
                      ),
                      Text(
                        "${widget.userQuantity.toString()}",
                        // style: AppTheme.of(context).subtitle1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 6, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Standard Shipping Fee',
                        // style: AppTheme.of(context).subtitle2,
                      ),
                      Text(
                        "RM ${shippingfee.toStringAsFixed(2)}",
                        // style: AppTheme.of(context).subtitle1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 6, 24, 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text("RM ${finaltotalprice.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Material(
                  // color: Colors.transparent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Container(
                    alignment: Alignment.bottomCenter,

                    width: double.infinity,
                    height: screenHeight * 0.105,
                    // height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color.fromARGB(49, 163, 178, 194),
                          offset: Offset(0, -2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(0),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 5,
                                  left: 38,
                                  right: 38,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(25.0),
                                  // side: BorderSide(color: Colors.black),
                                ),
                              ),
                              onPressed: () {
                                checkOutDialog();
                                print(widget.user.address);
                              },
                              child: Text(
                                "Place Barter Order ( RM ${finaltotalprice.toStringAsFixed(2)} )",
                                style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.bold),
                              )),
                        ]),
                  ),
                ),
                // Container(
                //   child: Text("data"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkOutDialog() async {
    if (widget.user.address == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Add a delivery address",
              style: TextStyle(fontSize: 16),
            ),
            content: Container(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              labelText: 'Enter your address',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02,
                                horizontal: screenHeight * 0.02,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  String address = _addressController.text;
                  _addAddress(address);
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (content) => PaymentScreen(
                    user: widget.user,
                    userQuantity: userqty,
                    finaltotalPrice: finaltotalprice,
                    useritem: widget.useritem,
                  )));
    }
  }

  void _addAddress(String address) {
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_final/php/update_profile.php"),
        body: {
          "userid": widget.user.id,
          "address": _addressController.text,
        }).then((response) async {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Address added success")));

        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (content) => PaymentScreen(
                      user: widget.user,
                      userQuantity: userqty,
                      finaltotalPrice: finaltotalprice,
                      useritem: widget.useritem,
                    )));
        setState(() {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Address added fail")));
      }
    });
  }
}
