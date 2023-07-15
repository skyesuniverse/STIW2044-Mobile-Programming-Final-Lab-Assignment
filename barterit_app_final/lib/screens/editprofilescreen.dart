import 'dart:convert';
import 'dart:io';
import 'package:barterit_app_final/models/user.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late double screenHeight, screenWidth, cardwitdh;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _newpassEditingController =
      TextEditingController();
  final TextEditingController _oldpassEditingController =
      TextEditingController();
  bool _oldpasswordVisible = true;
  bool _newpasswordVisible = true;
  File? _image;
  var pathAsset = "assets/images/profile.png";

  @override
  void initState() {
    super.initState();
    _nameEditingController.text = widget.user.name.toString();
    _emailEditingController.text = widget.user.email.toString();
    // _newpassEditingController.text = widget.user.itemQty.toString();
    // _oldpassEditingController.text = widget.user.itemState.toString();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        // backgroundColor: Colors.transparent,
        // elevation: 0.0,
        title: const Text(
          "Edit Profile",
          // style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _updateImageDialog();
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 55.0,
                            backgroundImage: AssetImage(
                                'assets/images/loggedin_profile.jpg'),
                          ),
                          CircleAvatar(
                            radius: 55.0,
                            backgroundImage: AssetImage(
                                'assets/images/loggedin_profile.jpg'),
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
                                size: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    /////////////
                    TextFormField(
                      enabled: false, //to restrict user from entering info
                      // initialValue: '+1 123 456 7890',
                      controller: _emailEditingController,
                      validator: (val) => val!.isEmpty || (val.length < 3)
                          ? "Item name must be longer than 3"
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    /////////////
                    SizedBox(height: 16.0),
                    /////////////
                    TextFormField(
                      controller: _nameEditingController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    // /////////////
                    // SizedBox(height: 16.0),
                    // /////////////
                    // TextFormField(
                    //   initialValue: '+1 123 456 7890',
                    //   decoration: InputDecoration(
                    //     labelText: 'Phone',
                    //     labelStyle: TextStyle(
                    //       fontSize: 16.0,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //     border: UnderlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: Colors.black,
                    //         width: 1.0,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    /////////////
                    SizedBox(height: 16.0),
                    /////////////
                    TextFormField(
                      // initialValue: 'Enter Old Password',
                      controller: _oldpassEditingController,
                      obscureText: _oldpasswordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _oldpasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _oldpasswordVisible = !_oldpasswordVisible;
                            });
                          },
                        ),
                        hintText: "Enter old password",
                        labelText: 'Old Password',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    /////////////
                    SizedBox(height: 16.0),
                    /////////////
                    TextFormField(
                      // initialValue: 'Enter Old Password',
                      controller: _newpassEditingController,
                      obscureText: _newpasswordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _newpasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _newpasswordVisible = !_newpasswordVisible;
                            });
                          },
                        ),
                        hintText: "Enter new password",
                        labelText: 'New Password',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    // TextFormField(
                    //   textInputAction: TextInputAction.next,
                    //   validator: (val) => val!.isEmpty || (val.length < 3)
                    //       ? "Item name must be longer than 3"
                    //       : null,
                    //   onFieldSubmitted: (v) {},
                    //   // controller: _itemnameEditingController,
                    //   keyboardType: TextInputType.text,
                    //   decoration: const InputDecoration(
                    //     labelText: 'John Doe',
                    //     labelStyle: TextStyle(),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(width: 2.0),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      width: screenWidth / 1.25,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            editProfileDialog();
                          },
                          child: const Text("Save")),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void editProfileDialog() {}

  _updateImageDialog() {
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

  void _updateProfileImage() {}

  // Future<void> _updateProfileImage() async {
  //   if (_image == null) {
  //     // Fluttertoast.showToast(
  //     //     msg: "No image available",
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.BOTTOM,
  //     //     timeInSecForIosWeb: 1,
  //     //     fontSize: 16.0);
  //     return;
  //   }
  //   File imageFile = File(_image!.path);
  //   print(imageFile);
  //   String base64Image = base64Encode(imageFile.readAsBytesSync());
  //   // print(base64Image);
  //   http.post(
  //       Uri.parse("${MyConfig().SERVER}/mynelayan/php/update_profile.php"),
  //       body: {
  //         "userid": widget.user.id.toString(),
  //         "image": base64Image.toString(),
  //       }).then((response) {
  //     var jsondata = jsonDecode(response.body);
  //     print(jsondata);
  //     if (response.statusCode == 200 && jsondata['status'] == 'success') {
  //       Fluttertoast.showToast(
  //           msg: "Success",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           fontSize: 16.0);
  //       val = random.nextInt(1000);
  //       setState(() {});
  //       // DefaultCacheManager manager = DefaultCacheManager();
  //       // manager.emptyCache(); //clears all data in cache.
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: "Failed",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           fontSize: 16.0);
  //     }
  //   });
}
