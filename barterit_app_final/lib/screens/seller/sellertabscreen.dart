import 'dart:convert';
import 'dart:developer';
import 'package:barterit_app_final/models/item.dart';
import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/myconfig.dart';
import 'package:barterit_app_final/screens/seller/edititemdetailsscreen.dart';
import 'package:barterit_app_final/screens/seller/newitemscreen.dart';
import 'package:barterit_app_final/screens/seller/barterorder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SellerTabScreen extends StatefulWidget {
  final User user;

  const SellerTabScreen({super.key, required this.user});

  @override
  State<SellerTabScreen> createState() => _SellerTabScreenState();
}

class _SellerTabScreenState extends State<SellerTabScreen> {
  String maintitle = 'Seller';
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  late List<Widget> tabchildren;
  List<Item> itemList = <Item>[];
  String status = "Loading...";
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  TextEditingController searchController = TextEditingController();
//code below is for pagination
  int numofpage = 1, curpage = 1;
  int numberofresult = 0;
  var color;

  @override
  void initState() {
    super.initState();
    loadsellerItems();
    print('Seller');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  Future<void> _refresh() async {
    loadsellerItems();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          title: Text(maintitle),
          actions: [
            itemList.isEmpty
                ? Center()
                : PopupMenuButton(itemBuilder: (context) {
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Barter Order"),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("New"),
                      ),
                    ];
                  }, onSelected: (value) async {
                    if (value == 0) {
                      if (widget.user.id.toString() == "na") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Please login/register an account")));
                        return;
                      }
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => BarterOrderScreen(
                                    /////////////////////////
                                    user: widget.user,
                                  )));
                    } else if (value == 1) {
                    } else if (value == 2) {}
                  }),
          ],
        ),
        body: itemList.isEmpty
            ? Center(
                child: Text(status),
              )
            : Column(
                children: [
                  Container(
                    height: 24,
                    color: Theme.of(context).colorScheme.primary,
                    alignment: Alignment.center,
                    child: Text(
                      "${itemList.length} Item Found",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(itemList.length, (index) {
                        return Card(
                          child: InkWell(
                            onLongPress: () {
                              onDeleteDialog(index);
                            },
                            onTap: () async {
                              Item singleItem =
                                  Item.fromJson(itemList[index].toJson());
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) =>
                                          EditItemDetailsScreen(
                                            user: widget.user,
                                            useritem: singleItem,
                                          )));
                              loadsellerItems();
                            },
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  width: screenWidth,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${MyConfig().SERVER}/barterit_final/assets/items/${itemList[index].itemId}_1.png",
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                Text(
                                  itemList[index].itemName.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "RM ${double.parse(itemList[index].itemPrice.toString()).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${itemList[index].itemQty} available",
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ), ////section for pagination
                  SizedBox(
                    height: 28,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: numofpage,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        //build the list for textbutton with scroll
                        if ((curpage - 1) == index) {
                          //set current page number active
                          color = Colors.black;
                        } else {
                          color = Colors.black38;
                        }
                        return TextButton(
                            onPressed: () {
                              curpage = index + 1;
                              loadsellerItems();
                            },
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  color: color,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ));
                      },
                    ),
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (widget.user.id != "na") {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => NewItemScreen(
                            user: widget.user,
                          )));
              loadsellerItems();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please login/register an account")));
            }
          },
          child: const Text(
            "+",
            style: TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }

  void loadsellerItems() {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
        status = "Please Login first...";
      });
      return;
    }

    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_final/php/load_items.php"),
        body: {
          'userid': widget.user.id,
          'pageno': curpage.toString()
        }).then((response) {
      print(response.body);
      print(widget.user.id);
      //log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          numofpage = int.parse(jsondata['numofpage']); //get number of pages
          numberofresult = int.parse(jsondata['numberofresult']);
          var extractdata = jsondata['data'];
          extractdata['items'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        } else {
          status = "Please Login first...";
          setState(() {});
        }
        setState(() {});
      }
    });
  }

  void onDeleteDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text(
              "Delete ${itemList[index].itemName}?",
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () {
                  deleteCatch(index);
                  Navigator.of(context).pop();
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
        });
  }

  void deleteCatch(int index) {
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_final/php/delete_item.php"),
        body: {
          "userid": widget.user.id,
          "itemid": itemList[index].itemId
        }).then((response) {
      print(response.body);
      //catchList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
          loadsellerItems();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Failed")));
        }
      }
    });
  }

  void showsearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: const Text(
            "Search?",
            style: TextStyle(),
          ),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        labelStyle: TextStyle(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      String search = searchController.text;
                      searchItem(search);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Search"),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
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
  }

  void searchItem(String search) {
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_final/php/load_items.php"),
        body: {"search": search}).then((response) {
      //print(response.body);
      log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['items'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }
        setState(() {});
      }
    });
  }
}
