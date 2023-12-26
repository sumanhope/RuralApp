import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:rural/User/loginpage.dart';
import 'package:rural/theme/appcolors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var box = const SizedBox(
    height: 20,
  );
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
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
    String text = emailController.text;
    if (text == '') {
      debugPrint("Please fill the email address.");
      errorDialog("Please fill email address");
    } else {
      passwordReset();
    }
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim())
          .then(
        (value) {
          errorDialog("Mail has been sent to the above email");
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  Widget buildUser() {
    return TextField(
      controller: emailController,
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
        suffixIcon: emailController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => emailController.clear(),
              ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColor.iconColor, width: 3),
        ),
      ),
      style: const TextStyle(
        color: AppColor.textColor,
        fontSize: 15,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainCardColor,
      appBar: AppBar(
        title: const Text("Reset Password"),
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
                child: Text(
                  "Enter the email assoociated with your account and we'll send an email with instructions to reset your password",
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
            Container(
              alignment: const Alignment(60, 1),
              child: const Text(
                "Email address                                                           ",
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
                        Navigator.of(context).pop(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const LoginPage();
                            },
                          ),
                        );
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
