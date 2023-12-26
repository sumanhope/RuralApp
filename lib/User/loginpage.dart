import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rural/User/forgotpass.dart';
import 'package:rural/landingpage.dart';
import 'package:rural/User/signuppage.dart';
import 'package:rural/theme/appcolors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
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

  Future signIn(String useremail, String userpass) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.iconColor,
            ),
          );
        });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: useremail, password: userpass)
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LandingPage(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        errorDialog("Account doesn't exist");
      } else if (e.code == 'wrong-password') {
        errorDialog("Email or password doesn't match");
      } else if (e.code == 'invalid-email') {
        errorDialog("The email address is badly formatted");
      } else {
        errorDialog(e.toString());
      }
    }
  }

  Widget buildUser() {
    return TextField(
      controller: usernameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.backgroundColor,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColor.iconColor, width: 3),
        ),
        labelText: 'Email',
        labelStyle: const TextStyle(
          color: AppColor.iconColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: const Icon(
          Icons.person,
          color: AppColor.iconColor,
          size: 30,
        ),
        suffixIcon: usernameController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => usernameController.clear(),
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
        title: const Text("Login"),
        backgroundColor: AppColor.mainCardColor,
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
                      height: 30,
                    ),
                    Container(
                      child: buildPassword(),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColor.iconColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const ResetPasswordScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.iconColor,
                        ),
                        onPressed: () {
                          if (usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            signIn(usernameController.text.trim(),
                                passwordController.text.trim());
                          } else {
                            errorDialog("Please fill both fields");
                          }
                        },

                        //Icon(Icons.chevron_right_rounded),
                        child: const Text(
                          "LOGIN",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have a account?',
                          style: TextStyle(
                            color: AppColor.iconColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            'Click Here',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                          },
                        ),
                      ],
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
