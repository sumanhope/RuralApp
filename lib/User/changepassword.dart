import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rural/landingpage.dart';

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
  Future changepass(oldpassword, newpassword) async {
    String email = currentuser.email!;
    debugPrint(email);
    var cred =
        EmailAuthProvider.credential(email: email, password: oldpassword);
    await currentuser.reauthenticateWithCredential(cred).then((value) {
      currentuser.updatePassword(newpassword);
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
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
                style: TextStyle(fontSize: 17, color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: oldpasscontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Old Password"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: newpasscontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("New Password"),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              height: 50,
              child: ElevatedButton(
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
                    print("Fill both fields");
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
