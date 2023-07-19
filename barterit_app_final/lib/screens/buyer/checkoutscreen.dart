import 'dart:io';
import 'package:barterit_app_final/models/item.dart';
import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/myconfig.dart';
import 'package:barterit_app_final/screens/buyer/billscreen.dart';
import 'package:barterit_app_final/screens/shared/profiletabscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
  late double screenHeight, screenWidth, cardwitdh;
  List<File?> selectedImages = [null, null, null];

  @override
  void initState() {
    super.initState();
    qty = int.parse(widget.useritem.itemQty.toString());
    totalprice = double.parse(widget.useritem.itemPrice.toString());
    singleprice = double.parse(widget.useritem.itemPrice.toString());
    finaltotalprice = widget.totalPrice + shippingfee;
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
                                  Text(widget.useritem.itemCategory.toString()),
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
              // Flexible(
              //   flex: 4,
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              //     child: Card(
              //       child: ListView(
              //         children: [
              //           Stack(
              //             children: [
              //               CarouselSlider(
              //                 items: [
              //                   for (var i = 0; i < selectedImages.length; i++)
              //                     Container(
              //                       alignment: Alignment.center,
              //                       width: screenWidth,
              //                       child: CachedNetworkImage(
              //                         placeholder: (context, url) =>
              //                             const CircularProgressIndicator(),
              //                         errorWidget: (context, url, error) =>
              //                             const Icon(Icons.error),
              //                         imageUrl:
              //                             "${MyConfig().SERVER}/barterit_final/assets/items/${widget.useritem.itemId}_${i + 1}.png",
              //                       ),
              //                     )
              //                 ],
              //                 options: CarouselOptions(
              //                   autoPlay: true,
              //                   autoPlayCurve: Curves.fastOutSlowIn,
              //                   enableInfiniteScroll: false,
              //                   autoPlayAnimationDuration:
              //                       Duration(milliseconds: 800),
              //                   viewportFraction: 1.0,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10),
              // Expanded(
              //   flex: 6,
              //   child: SingleChildScrollView(
              //     child: Padding(
              //       padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(
              //                 widget.useritem.itemName.toString(),
              //                 style: TextStyle(
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               Text(
              //                 "RM ${double.parse(widget.useritem.itemPrice.toString()).toStringAsFixed(2)}",
              //                 style: TextStyle(
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w800,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 8),
              //           Text(
              //             widget.useritem.itemCategory.toString(),
              //             style: TextStyle(
              //               fontSize: 12,
              //               color: Colors.grey[700],
              //             ),
              //           ),
              //           SizedBox(height: 20),
              //           Text(
              //             widget.useritem.itemDesc.toString(),
              //             textAlign: TextAlign.justify,
              //             style: TextStyle(
              //               fontSize: 15,
              //             ),
              //           ),
              //           SizedBox(height: 22),
              //           ////////Location
              //           Container(
              //             alignment: Alignment.bottomLeft,
              //             child: Row(
              //               children: [
              //                 Icon(Icons.location_on, color: Colors.grey),
              //                 SizedBox(width: 5),
              //                 Flexible(
              //                   child: Text(
              //                     widget.useritem.itemLocality.toString(),
              //                     style: TextStyle(
              //                       fontSize: 15.0,
              //                       color: Colors.grey,
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(width: 25),
              //                 Icon(Icons.flag_sharp, color: Colors.grey),
              //                 SizedBox(width: 5),
              //                 Flexible(
              //                   child: Text(
              //                     widget.useritem.itemState.toString(),
              //                     style: TextStyle(
              //                       fontSize: 15.0,
              //                       color: Colors.grey,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Price Breakdown
              // Container(
              //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Price Breakdown:',
              //         style: TextStyle(
              //           fontSize: 18.0,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       SizedBox(height: 8.0),
              //       Text('Basic Price: \$10'),
              //       Text('Taxes: \$2'),
              //       Text('Fee: \$1'),
              //       Text('Total Price: \$13'),
              //       Spacer(),
              //     ],
              //   ),
              // ),
              // Place Order / Checkout Button
              // Container(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Place Order / Checkout Logic
              //     },
              //     child: Text('Place Order'),
              //   ),
              // ),
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
                        // Container(
                        //   height: screenHeight * 0.08,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white54,
                        //     borderRadius: BorderRadius.circular(6),
                        //     shape: BoxShape.rectangle,
                        //     // border: Border.all(
                        //     //   color: Colors.black,
                        //     //   width: 2,
                        //     // ),
                        //   ),
                        //   child: IntrinsicHeight(
                        //     child: Row(
                        //       children: [
                        //         IconButton(
                        //             onPressed: () {
                        //               if (userqty <= 1) {
                        //                 userqty = 1;
                        //                 totalprice = singleprice * userqty;
                        //               } else {
                        //                 userqty = userqty - 1;
                        //                 totalprice = singleprice * userqty;
                        //               }
                        //               setState(() {});
                        //             },
                        //             icon: const Icon(Icons.remove),
                        //             iconSize: screenWidth * 0.06),
                        //         // VerticalDivider(
                        //         //   color: Color.fromARGB(255, 155, 154, 154),
                        //         //   thickness: 1,
                        //         //   endIndent: 10,
                        //         //   indent: 8,
                        //         // ),
                        //         SizedBox(
                        //           width: screenWidth * 0.01,
                        //         ),
                        //         Text(
                        //           userqty.toString(),
                        //           style: const TextStyle(
                        //               fontSize: 14, fontWeight: FontWeight.bold),
                        //         ),
                        //         SizedBox(width: screenWidth * 0.01),
                        //         // VerticalDivider(
                        //         //   color: Color.fromARGB(255, 155, 154, 154),
                        //         //   thickness: 1,
                        //         //   endIndent: 8,
                        //         //   indent: 8,
                        //         // ),
                        //         IconButton(
                        //           onPressed: () {
                        //             if (userqty >= qty) {
                        //               userqty = qty;
                        //               totalprice = singleprice * userqty;
                        //             } else {
                        //               userqty = userqty + 1;
                        //               totalprice = singleprice * userqty;
                        //             }
                        //             setState(() {});
                        //           },
                        //           icon: const Icon(Icons.add),
                        //           iconSize: screenWidth * 0.06,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Text(
                        //   "RM ${totalprice.toStringAsFixed(2)}",
                        //   style: const TextStyle(
                        //       fontSize: 24, fontWeight: FontWeight.bold),
                        // ),
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
                            onPressed: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) => BillScreen(
                                            user: widget.user,
                                            finaltotalprice: finaltotalprice,
                                          )));
                            },
                            child: Text(
                              "Place Barter Order ( RM ${finaltotalprice.toStringAsFixed(2)} )",
                              style: TextStyle(
                                  fontSize: 13.5, fontWeight: FontWeight.bold),
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
    );
  }

  void checkoutdialog() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => ProfileTabScreen(
                  user: widget.user,
                  // useritem: widget.usercatch,
                )));
  }
}
