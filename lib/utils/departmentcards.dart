import 'package:flutter/material.dart';
import 'package:rural/theme/appcolors.dart';

class GetCard extends StatelessWidget {
  const GetCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
    required this.size,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final VoidCallback press;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: size.width * 0.45,
        height: size.height * 0.19,
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColor.fillColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: AppColor.iconColor,
                size: 30,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: AppColor.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
