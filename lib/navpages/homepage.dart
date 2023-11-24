import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rural/Information/information.dart';
import 'package:rural/Information/digital.dart';
import 'package:rural/Information/emergency.dart';
import 'package:rural/Information/intro.dart';
import 'package:rural/navpages/noticepage.dart';
import 'package:rural/Department/plans.dart';
import 'package:rural/theme/appcolors.dart';
import '../Department/education.dart';
import '../Department/employment.dart';
import '../chatpage/citizencomplaint.dart';
import '../utils/commuicationcards.dart';
import '../utils/departmentcards.dart';
import '../utils/othercards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var textstyle = const TextStyle(
    color: Colors.black,
    fontSize: 15,
  );

  final User? user = FirebaseAuth.instance.currentUser;

  String _uid = " ";
  String username = "";

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

  void getData() async {
    _uid = user!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      username = userDoc.get('username');
      isAdmin = userDoc.get('isAdmin');
    });
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to exit the application?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipOval(
              child: Image.asset(
                'images/neplogo.png',
                fit: BoxFit.cover,
                width: 30,
                height: 30,
              ),
            ),
          ),
          title: const Text("Home"),
          centerTitle: true,
          backgroundColor: AppColor.mainCardColor,
        ),
        backgroundColor: AppColor.mainCardColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 350,
                decoration: const BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Myagde this week !",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Departments < >",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.6,
                            color: AppColor.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: SizedBox(
                      //color: Colors.lightBlue,
                      width: size.width,
                      height: 320,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GetCard(
                                icon: Icons.school_outlined,
                                text: "Education",
                                size: size,
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EducationPage(
                                        role: isAdmin,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              GetCard(
                                icon: Icons.important_devices,
                                text: "Notice",
                                size: size,
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const NoticePage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GetCard(
                                icon: Icons.business_center,
                                text: "Employment",
                                size: size,
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmploymentPage(
                                        role: isAdmin,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              GetCard(
                                icon: Icons.description,
                                text: "Plans",
                                size: size,
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlansPage(
                                        role: isAdmin,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Communication < >",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: AppColor.textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: SizedBox(
                      width: size.width,
                      height: 140,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          CommuncationCard(
                            title: "Citizen Complaint",
                            description: "Voice your concerns and queries",
                            icon: Icons.comment,
                            size: size,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CitizenComplaint()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Information < >",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: AppColor.textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: SizedBox(
                      //color: Colors.purple,
                      width: size.width,
                      height: 140,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            CommuncationCard(
                              title: "Representatives",
                              description:
                                  "Know the employees and representatives",
                              icon: Icons.groups_outlined,
                              size: size,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const Representatives(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            CommuncationCard(
                              title: "Digital Profile",
                              description:
                                  "Know the statistics of the municipality",
                              icon: Icons.badge,
                              size: size,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DigitalProfile(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Other Information < >",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: AppColor.textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: SizedBox(
                      //color: Colors.purple,
                      width: size.width,
                      height: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OtherCards(
                            icon: Icons.info,
                            text: "Intro",
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Intro(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          OtherCards(
                            icon: Icons.medical_services,
                            text: "Services",
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Emergency(
                                    role: isAdmin,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
