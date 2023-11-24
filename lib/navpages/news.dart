import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rural/navpages/addnews.dart';
import 'package:rural/navpages/noticepage.dart';
import 'package:rural/theme/appcolors.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final User? user = FirebaseAuth.instance.currentUser;

  String _uid = " ";

  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
    } else {
      getData();
    }
  }

  Future errorDialog(String error) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          backgroundColor: Colors.green,
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

  void getData() async {
    _uid = user!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      isAdmin = userDoc.get('isAdmin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("News and Notice"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.mainCardColor,
        ),
        backgroundColor: AppColor.mainCardColor,
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ChatsOption(
                title: "View News and Notice",
                description: "Shows all the news or notice added by admin",
                icon: Icons.newspaper,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NoticePage(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ChatsOption(
                title: "Add News or Notice",
                description: "Only admin can added news/notice",
                icon: Icons.add_card,
                press: () {
                  if (isAdmin) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNews(),
                      ),
                    );
                  } else {
                    errorDialog("Admin access require");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatsOption extends StatelessWidget {
  const ChatsOption({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: InkWell(
        onTap: press,
        child: SizedBox(
          child: Container(
            width: 370,
            height: 130,
            //color: Colors.purple,
            decoration: BoxDecoration(
              color: AppColor.cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColor.fillColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: AppColor.iconColor,
                      size: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 19.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textColor,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          description,
                          softWrap: true,
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColor.secondaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
