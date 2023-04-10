import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rural/navpages/chatpage.dart';
import 'package:rural/navpages/homepage.dart';
import 'package:rural/navpages/noticepage.dart';
import 'package:rural/navpages/profilepage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<Widget> pages = [
    const HomePage(),
    const ChatPage(),
    const NoticePage(),
    const ProfilePage(),
  ];

  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentStep],
      backgroundColor: const Color.fromARGB(255, 220, 217, 217),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.green,
        animationDuration: const Duration(milliseconds: 300),
        height: 60,
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.chat,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.newspaper,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          )
        ],
        index: currentStep,
        onTap: (index) {
          setState(() {
            currentStep = index;
          });
        },
      ),
    );
  }
}
