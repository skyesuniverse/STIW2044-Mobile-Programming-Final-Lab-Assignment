import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/myconfig.dart';
import 'package:barterit_app_final/screens/editprofilescreen.dart';
import 'package:barterit_app_final/splashscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTabScreen extends StatefulWidget {
  final User user;

  const ProfileTabScreen({super.key, required this.user});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  late List<Widget> tabchildren;
  File? _image;
  var pathAsset = "assets/images/profile.png";
  var val = 50;
  String maintitle = 'Profile';
  late double screenHeight, screenWidth, cardwitdh;
  late bool hasProfileImage = false;

  @override
  void initState() {
    super.initState();
    print('Profile');

    // Update the hasProfileImage property of the User object
    if (widget.user.id != "0") {
      http
          .head(Uri.parse(
              "${MyConfig().SERVER}/barterit_final/assets/profileimages/${widget.user.id}.png?v=$val"))
          .then((response) {
        setState(() {
          hasProfileImage = response.statusCode == 200;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
        // actions: <Widget>[
        //   Padding(
        //       padding: EdgeInsets.only(right: 20.0),
        //       child: GestureDetector(
        //         onTap: () {
        //           _gotologout();
        //         },
        //         child: const Icon(
        //           Icons.logout_rounded,
        //           size: 26.0,
        //         ),
        //       )),
        // ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 9.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.indigoAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _updateImageDialog();
                        },
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: screenWidth * 0.1,
                              child: ClipOval(
                                child: hasProfileImage
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            "${MyConfig().SERVER}/barterit_final/assets/profileimages/${widget.user.id}.png?v=$val",
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          pathAsset,
                                          fit: BoxFit.contain,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.network(
                                          "${MyConfig().SERVER}/barterit_final/assets/profileimages/0.png",
                                          scale: 2,
                                        ),
                                      )
                                    : Image.asset(
                                        pathAsset,
                                        fit: BoxFit.contain,
                                      ),
                              ),

                              // child: Container(
                              //   child: CachedNetworkImage(
                              //     imageUrl:
                              //         "${MyConfig().SERVER}/barterit_final/assets/profileimages/${widget.user.id}.png?",
                              //   ),
                              // )
                              // backgroundImage: CachedNetworkImageProvider(
                              //     "${MyConfig().SERVER}/barterit_final/assets/profileimages/${widget.user.id}.png?"),
                              // child: Image(
                              //   image: _image == null
                              //       ? AssetImage(pathAsset)
                              //       : FileImage(_image!) as ImageProvider,
                              //   fit: BoxFit.contain,
                              // )
                              // CachedNetworkImage(
                              //     imageUrl:
                              //         "${MyConfig().SERVER}/barterit_final/assets/profileimages/${widget.user.id}.png?v=$val",
                              //     placeholder: (context, url) =>
                              //         const LinearProgressIndicator(),
                              //     errorWidget: (context, url, error) => Image.network(
                              //           "${MyConfig().SERVER}/barterit_final/assets/profileimages/0.png",
                              //           scale: 2,
                              //         )),
                              // backgroundImage:
                              //     AssetImage('assets/images/loggedin_profile.jpg'),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.edit,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.name.toString(),
                            style: TextStyle(
                              fontSize: screenWidth * 0.07,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            widget.user.email.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                          // SizedBox(height: screenHeight * 0.015),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: ElevatedButton(
                          //     onPressed: onEditProfile,
                          //     child: Text('Edit Account'),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              ListTile(
                dense: true,
                // tileColor: Colors.amber,
                leading: Icon(Icons.shopping_bag_outlined),
                title: Text('My Purchase'),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {},
              ),
              Divider(),
              SizedBox(height: screenHeight * 0.0002),
              ListTile(
                dense: true,
                // tileColor: Colors.amber,
                leading: Icon(Icons.mode_edit_outlined),
                title: Text('Change Name'),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  _updateNameDialog();
                },
              ),
              Divider(),
              SizedBox(height: screenHeight * 0.0002),
              ListTile(
                dense: true,
                // tileColor: Colors.amber,
                leading: Icon(Icons.lock_outline),
                title: Text('Change Password'),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  _changePassDialog();
                },
              ),
              Divider(),
              ListTile(
                dense: true,
                leading: Icon(Icons.power_settings_new),
                title: Text('Logout'),
                onTap: () {
                  _gotologout();
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       Container(
      //         padding: EdgeInsets.all(8),
      //         height: screenHeight * 0.4,
      //         width: screenWidth,
      //         child: Card(
      //           // color: Colors.blue,
      //           child: Column(children: [
      //             const Text(
      //               "Profile info",
      //               style: TextStyle(
      //                 fontSize: 20,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 15,
      //             ),
      //             // Container(
      //             //   margin: EdgeInsets.all(4),
      //             //   width: screenWidth * 0.4,
      //             //   child: Image.asset(
      //             //     "assets/images/loggedin_profile.jpg",
      //             //   ),
      //             // ),
      //             const CircleAvatar(
      //               radius: 78.0,
      //               backgroundImage: AssetImage(
      //                 "assets/images/loggedin_profile.jpg",
      //               ),
      //               backgroundColor: Colors.transparent,
      //             ),
      //             Expanded(
      //               flex: 10,
      //               child: Column(
      //                 children: [
      //                   Text(
      //                     widget.user.name.toString(),
      //                     style: const TextStyle(fontSize: 24),
      //                   ),
      //                   Text(widget.user.email.toString()),
      //                 ],
      //               ),
      //             ),
      //           ]),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  ////////////////////////////
  Future<void> _gotologout() async {
    print(widget.user.name);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Logging out"),
          content: Text("Are your sure?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes"),
              onPressed: () async {
                Navigator.of(context).pop();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('email', '');
                await prefs.setString('pass', '');
                print("LOGOUT");
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()));
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Name?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter new name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenHeight * 0.02,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String newname = _nameController.text;
                _updateName(newname);
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
  }

  void _updateName(String newname) {
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_final/php/update_profile.php"),
        body: {
          "userid": widget.user.id,
          "newname": newname,
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Name changed succesfully.")));
        Navigator.pop(context);
        setState(() {
          widget.user.name = newname;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Name changed failed.")));
        Navigator.pop(context);
      }
    });
  }

  void _updateImageDialog() {
    if (widget.user.id == "0") {
      // Fluttertoast.showToast(
      //     msg: "Please login/register",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     fontSize: 16.0);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    onPressed: () => {
                          Navigator.of(context).pop(),
                          _galleryPicker(),
                        },
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery")),
                TextButton.icon(
                    onPressed: () =>
                        {Navigator.of(context).pop(), _cameraPicker()},
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera")),
              ],
            ));
      },
    );
  }

  Future<void> _galleryPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1200,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      cropImage();
    }
  }

  Future<void> _cameraPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1200,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      cropImage();
    }
  }

  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      File imageFile = File(croppedFile.path);
      _image = imageFile;
      _updateProfileImage();
      setState(() {});
    }
  }

  Future<void> _updateProfileImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No Image Available.")));
      return;
    }
    File imageFile = File(_image!.path);
    print(imageFile);
    String base64Image = base64Encode(imageFile.readAsBytesSync());
    // print(base64Image);
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_final/php/update_profile.php"),
        body: {
          "userid": widget.user.id.toString(),
          "image": base64Image.toString(),
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Edit Success")));
        setState(() {});
        // DefaultCacheManager manager = DefaultCacheManager();
        // manager.emptyCache(); //clears all data in cache.
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Edit Failed")));
        Navigator.pop(context);
      }
    });
  }

  void _changePassDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenHeight * 0.03,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Change Password?",
            style: TextStyle(),
          ),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _oldpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Old Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                              horizontal: screenHeight * 0.02,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        TextFormField(
                          controller: _newpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'New Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                              horizontal: screenHeight * 0.02,
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
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                changePass();
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
  }

  void changePass() {
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterit_final/php/update_profile.php"),
        body: {
          "userid": widget.user.id,
          "oldpass": _oldpasswordController.text,
          "newpass": _newpasswordController.text,
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Change Success")));
        setState(() {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Change Failed")));
      }
    });
  }

  // onEditProfile() {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (content) => EditProfileScreen(
  //                 user: widget.user,
  //               )));
  // }
}
