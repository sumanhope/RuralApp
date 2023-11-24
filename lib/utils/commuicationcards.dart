import 'package:flutter/material.dart';
import 'package:rural/theme/appcolors.dart';

class CommuncationCard extends StatelessWidget {
  const CommuncationCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.press,
    required this.size,
  }) : super(key: key);
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback press;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: size.width * 0.75,
        height: size.height * 0.16,
        //color: Colors.purple,
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColor.fillColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 40,
                color: AppColor.iconColor,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textColor,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    description,
                    softWrap: true,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 2,
            ),
          ],
        ),
      ),
    );
  }
}
