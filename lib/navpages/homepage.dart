import 'package:flutter/material.dart';
import 'package:rural/education.dart';
import 'package:rural/employment.dart';
import 'package:rural/navpages/noticepage.dart';
import 'package:rural/plans.dart';

import '../chatpage/citizencomplaint.dart';
import '../utils/commuicationcards.dart';
import '../utils/departmentcards.dart';
import '../utils/maindrawer.dart';
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
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
      ),
      endDrawer: MainDrawer(),
      backgroundColor: const Color.fromARGB(255, 220, 217, 217),
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: const BoxDecoration(
              color: Colors.green,
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Departments < >",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.6,
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
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EducationPage(),
                                ),
                              );
                            },
                          ),
                          GetCard(
                            icon: Icons.important_devices,
                            text: "Notice",
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
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EmploymentPage(),
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
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PlansPage(),
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CitizenComplaint()),
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                          description: "Know the employees and representatives",
                          icon: Icons.groups_outlined,
                          press: () {},
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CommuncationCard(
                          title: "Digital Profile",
                          description:
                              "Know the statistics of the municipality",
                          icon: Icons.badge,
                          press: () {},
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                        press: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OtherCards(
                        icon: Icons.medical_services,
                        text: "Services",
                        press: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
