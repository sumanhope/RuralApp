import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:rural/landingpage.dart';
import 'package:rural/theme/appcolors.dart';

class Username extends StatefulWidget {
  const Username({super.key, required this.userid});
  final String userid;
  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  var box = const SizedBox(
    height: 20,
  );
  final usernamecontroller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    usernamecontroller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    super.dispose();
  }

  Future errorDialog(String error) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          backgroundColor: AppColor.backgroundColor,
          elevation: 5,
          title: Text(
            error,
            style: const TextStyle(
              letterSpacing: 2.5,
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  checkaccount() async {
    String username = usernamecontroller.text;
    String uid = widget.userid;
    if (username == '') {
      errorDialog("Please fill the field");
    } else {
      updateuser(uid, username);
    }
  }

  Future updateuser(
    String uid,
    String username,
  ) async {
    final usercollection = FirebaseFirestore.instance.collection('users');
    final docRef = usercollection.doc(uid);

    try {
      await docRef.update({
        "username": username,
      }).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LandingPage()),
        );
      });
    } catch (e) {
      debugPrint("some error occured $e");
    }
  }

  Widget buildUser() {
    return TextField(
      controller: usernamecontroller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.backgroundColor,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColor.iconColor, width: 3),
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: AppColor.iconColor,
          size: 30,
        ),
        suffixIcon: usernamecontroller.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => usernamecontroller.clear(),
              ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColor.iconColor, width: 3),
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainCardColor,
      appBar: AppBar(
        title: const Text("Username"),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            box,
            const Padding(
              padding: EdgeInsets.only(top: 8.0, left: 20),
              child: SizedBox(
                width: 350,
                child: Text(
                  "Input your new username on below field to change it.",
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 4,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColor.fillColor,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            box,
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Username",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColor.iconColor,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: Column(
                children: [
                  buildUser(),
                  box,
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        checkaccount();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.iconColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: AppColor.fillColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
