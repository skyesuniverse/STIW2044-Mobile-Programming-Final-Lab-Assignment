import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/screens/editprofilescreen.dart';
import 'package:barterit_app_final/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTabScreen extends StatefulWidget {
  final User user;

  const ProfileTabScreen({super.key, required this.user});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  String maintitle = 'Profile';
  late double screenHeight, screenWidth, cardwitdh;

  @override
  void initState() {
    super.initState();
    print('Profile');
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
                      CircleAvatar(
                        radius: screenWidth * 0.1,
                        backgroundImage:
                            AssetImage('assets/images/loggedin_profile.jpg'),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.name.toString(),
                            style: TextStyle(
                              fontSize: screenWidth * 0.065,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            widget.user.email.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: onEditProfile,
                              child: Text('Edit Account'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              ListTile(
                // tileColor: Colors.amber,
                leading: Icon(Icons.shopping_bag_outlined),
                title: Text('My Purchase'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text('Logout'),
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

  onEditProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => EditProfileScreen(
                  user: widget.user,
                )));
  }
}
