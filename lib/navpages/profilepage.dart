import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rural/User/changepassword.dart';
import 'package:rural/User/loginpage.dart';
import 'package:rural/User/username.dart';
import 'package:rural/landingpage.dart';
import 'package:rural/theme/appcolors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  String _uid = " ";
  String username = "Loading";
  String email = "Loading";

  @override
  void initState() {
    super.initState();
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
    } else {
      getData();
    }
  }

  void getData() async {
    _uid = user!.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      username = userDoc.get('username');
      email = userDoc.get('email');
    });
  }

  showWidget() {
    if (user == null) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 250,
              child: Text(
                "Please login using below button.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.iconColor,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.iconColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
              ),
            )
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipOval(
              child: Image.asset(
                'images/neplogo.png',
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ProfileMenu(
            text: username,
            firsticon: Icons.person,
            secondicon: Icons.chevron_right_sharp,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Username(
                    userid: _uid,
                  ),
                ),
              );
            },
          ),
          ProfileMenu(
            text: email,
            firsticon: Icons.email,
            secondicon: Icons.chevron_right_sharp,
            press: () {},
          ),
          ProfileMenu(
            text: "Change Password",
            firsticon: Icons.password,
            secondicon: Icons.chevron_right_sharp,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Changepassword(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Logout",
            firsticon: Icons.logout,
            secondicon: Icons.chevron_right_sharp,
            press: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LandingPage(),
                  ),
                );
              });
            },
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.mainCardColor,
            centerTitle: true,
          ),
          backgroundColor: AppColor.mainCardColor,
          body: Center(
            child: showWidget(),
          )),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final String text;
  final IconData firsticon, secondicon;
  final VoidCallback press;
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.firsticon,
    required this.secondicon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 10,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: AppColor.cardColor,
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              firsticon,
              size: 25,
              color: AppColor.iconColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: AppColor.textColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const Spacer(),
            Icon(
              secondicon,
              size: 30,
              color: AppColor.iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
