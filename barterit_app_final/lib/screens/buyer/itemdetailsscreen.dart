import 'dart:io';
import 'package:barterit_app_final/models/item.dart';
import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/myconfig.dart';
import 'package:barterit_app_final/screens/buyer/checkoutscreen.dart';
import 'package:barterit_app_final/screens/shared/loginscreen.dart';
import 'package:barterit_app_final/screens/shared/profiletabscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Item useritem;
  final User user;
  const ItemDetailsScreen(
      {super.key,
      required this.useritem,
      required this.user,
      required int page});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final TextEditingController _addressController = TextEditingController();
  late double screenHeight, screenWidth, cardwitdh;
  List<File?> selectedImages = [null, null, null];

  int qty = 0;
  int userqty = 1;
  double totalprice = 0.0;
  double singleprice = 0.0;
  int curpage = 1;

  @override
  void initState() {
    super.initState();
    qty = int.parse(widget.useritem.itemQty.toString());
    totalprice = double.parse(widget.useritem.itemPrice.toString());
    singleprice = double.parse(widget.useritem.itemPrice.toString());
  }

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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Item",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Card(
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        CarouselSlider(
                          items: [
                            for (var i = 0; i < selectedImages.length; i++)
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  imageUrl:
                                      "${MyConfig().SERVER}/barterit_final/assets/items/${widget.useritem.itemId}_${i + 1}.png",
                                ),
                              )
                          ],
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: false,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.useritem.itemName.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "RM ${double.parse(widget.useritem.itemPrice.toString()).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.useritem.itemCategory.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.useritem.itemDesc.toString(),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 22),
                    ////////Location
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey),
                          SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              widget.useritem.itemLocality.toString(),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 25),
                          Icon(Icons.flag_sharp, color: Colors.grey),
                          SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              widget.useritem.itemState.toString(),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            // color: Colors.transparent,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.105,
              // height: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(59, 243, 255, 252),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: screenHeight * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(6),
                        shape: BoxShape.rectangle,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (userqty <= 1) {
                                    userqty = 1;
                                    totalprice = singleprice * userqty;
                                  } else {
                                    userqty = userqty - 1;
                                    totalprice = singleprice * userqty;
                                  }
                                  setState(() {});
                                },
                                icon: const Icon(Icons.remove),
                                iconSize: screenWidth * 0.06),
                            SizedBox(
                              width: screenWidth * 0.01,
                            ),
                            Text(
                              userqty.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            IconButton(
                              onPressed: () {
                                if (userqty >= qty) {
                                  userqty = qty;
                                  totalprice = singleprice * userqty;
                                } else {
                                  userqty = userqty + 1;
                                  totalprice = singleprice * userqty;
                                }
                                setState(() {});
                              },
                              icon: const Icon(Icons.add),
                              iconSize: screenWidth * 0.06,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 5,
                          left: 38,
                          right: 38,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(25.0),
                          // side: BorderSide(color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        barteritdialog();
                        print(totalprice);
                      },
                      child: const Text(
                        "Barter It",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  void barteritdialog() {
    if (widget.user.id == "na") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Required'),
            content: const Text("Please log in to barter the item."),
            actions: [
              TextButton(
                onPressed: () async {
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (content) => LoginScreen(),
                    ),
                    (route) =>
                        false, // Remove all previous routes from the stack
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (widget.user.id.toString() == widget.useritem.userId.toString()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User cannot barter own item")));
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => CheckOutScreen(
                  user: widget.user,
                  useritem: widget.useritem,
                  totalPrice: totalprice, // Pass the total price
                  userQuantity: userqty, // Pass the user quantity
                  page: curpage,
                )));
  }

  void _addAddress(String address) {}
}
