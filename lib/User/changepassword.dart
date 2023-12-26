import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rural/landingpage.dart';
import 'package:rural/theme/appcolors.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  var oldpasscontroller = TextEditingController();
  var newpasscontroller = TextEditingController();

  var auth = FirebaseAuth.instance;
  var currentuser = FirebaseAuth.instance.currentUser!;

  Future errorDialog(String error) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
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

  Future changepass(oldpassword, newpassword) async {
    String email = currentuser.email!;
    debugPrint(email);
    var cred =
        EmailAuthProvider.credential(email: email, password: oldpassword);
    await currentuser.reauthenticateWithCredential(cred).then((value) {
      currentuser.updatePassword(newpassword);
    }).catchError((error) {
      errorDialog(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainCardColor,
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: Text(
                "Enter your old and new password on below field."
                " If you dont remember your old password, "
                "Click on forgot password on Login Page.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 17, color: AppColor.fillColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: oldpasscontroller,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColor.backgroundColor,
                  labelText: 'Old Password',
                  labelStyle: TextStyle(
                    color: AppColor.iconColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: AppColor.iconColor, width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: AppColor.iconColor, width: 3),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: newpasscontroller,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColor.backgroundColor,
                  labelText: 'New Password',
                  labelStyle: TextStyle(
                    color: AppColor.iconColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: AppColor.iconColor, width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
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
              ),
            ),
            SizedBox(
              width: 120,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.iconColor,
                ),
                onPressed: () async {
                  if (oldpasscontroller.text.isNotEmpty &&
                      newpasscontroller.text.isNotEmpty) {
                    await changepass(
                            oldpasscontroller.text, newpasscontroller.text)
                        .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LandingPage(),
                              ),
                            ));
                  } else {
                    errorDialog("Fill both fields");
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
