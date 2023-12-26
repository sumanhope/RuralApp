import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rural/landingpage.dart';
import 'package:rural/theme/appcolors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailcontroller = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  DateTime today = DateTime.now();

  final FirebaseAuth auth = FirebaseAuth.instance;
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

  Future signIn() async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordController.text.trim(),
      );
      final User user = auth.currentUser!;
      final uid = user.uid;
      String dateStr = "${today.day}-${today.month}-${today.year}";

      debugPrint(dateStr);
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'UserId': uid,
        'username': usernameController.text.trim(),
        'email': emailcontroller.text.trim(),
        'register': dateStr,
        'isAdmin': false,
      }).then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LandingPage(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorDialog(e.toString());
    }
  }

  Widget buildEmail() {
    return TextField(
      controller: emailcontroller,
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColor.backgroundColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColor.iconColor, width: 3),
        ),
        labelText: 'Email',
        labelStyle: TextStyle(
          color: AppColor.iconColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(
          Icons.email,
          color: AppColor.iconColor,
          size: 30,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColor.iconColor, width: 3),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
    );
  }

  Widget buildUser() {
    return TextField(
      controller: usernameController,
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColor.backgroundColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColor.iconColor, width: 3),
        ),
        labelText: 'Username',
        labelStyle: TextStyle(
          color: AppColor.iconColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(
          Icons.person,
          color: AppColor.iconColor,
          size: 30,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColor.iconColor, width: 3),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  Widget buildPassword() {
    return TextField(
      controller: passwordController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.backgroundColor,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: AppColor.iconColor, width: 3),
        ),
        labelText: 'Password',
        labelStyle: const TextStyle(
          color: AppColor.iconColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: const Icon(
          Icons.key,
          color: AppColor.iconColor,
          size: 30,
        ),
        // suffixIcon: Icon(
        //   Icons.visibility_off,
        //   color: Colors.teal,
        //   size: 30,
        // ),
        suffixIcon: IconButton(
          icon: isPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
          color: AppColor.iconColor,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: AppColor.iconColor, width: 3),
        ),
      ),
      obscureText: isPasswordVisible,
      style: const TextStyle(
        color: Colors.black,
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
        backgroundColor: AppColor.mainCardColor,
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.asset(
                    'images/logo.png',
                    fit: BoxFit.contain,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                child: Column(
                  children: [
                    Container(
                      child: buildUser(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: buildEmail(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: buildPassword(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.iconColor,
                        ),
                        onPressed: () {
                          signIn();
                        },

                        //Icon(Icons.chevron_right_rounded),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
