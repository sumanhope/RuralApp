import 'package:flutter/material.dart';
import 'package:rural/theme/appcolors.dart';

class OtherCards extends StatelessWidget {
  const OtherCards({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColor.fillColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: AppColor.iconColor,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
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
