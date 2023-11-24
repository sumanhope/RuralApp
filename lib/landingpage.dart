import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rural/navpages/chatpage.dart';
import 'package:rural/navpages/homepage.dart';
import 'package:rural/navpages/news.dart';
import 'package:rural/navpages/profilepage.dart';
import 'package:rural/theme/appcolors.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    super.key,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<Widget> pages = [
    const HomePage(),
    const ChatPage(),
    const News(),
    const ProfilePage(),
  ];

  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentStep],
      backgroundColor: AppColor.mainCardColor,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: AppColor.backgroundColor,
        animationDuration: const Duration(milliseconds: 300),
        height: 60,
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: AppColor.iconColor,
          ),
          Icon(
            Icons.chat,
            size: 30,
            color: AppColor.iconColor,
          ),
          Icon(
            Icons.newspaper,
            size: 30,
            color: AppColor.iconColor,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: AppColor.iconColor,
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
