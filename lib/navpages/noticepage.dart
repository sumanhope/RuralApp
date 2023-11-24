import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rural/theme/appcolors.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final titlecontroller = TextEditingController();
  final datecontroller = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notice"),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
      ),
      backgroundColor: AppColor.mainCardColor,
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("notice").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColor.iconColor,
              ));
            } else if (snapshot.hasError) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 50,
                      color: AppColor.iconColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Something is wrong",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: AppColor.fillColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.find_in_page,
                      size: 50,
                      color: AppColor.iconColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "No Data found",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: AppColor.fillColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                DocumentSnapshot docs = snapshot.data!.docs[index];
                return Noticecard(
                  title: docs['title'],
                  desc: docs['description'],
                  date: docs['date'],
                  size: size,
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

class Noticecard extends StatelessWidget {
  const Noticecard({
    Key? key,
    required this.title,
    required this.desc,
    required this.date,
    required this.size,
  }) : super(key: key);
  final String title;
  final String date;
  final String desc;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 15,
                bottom: 8,
              ),
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: AppColor.secondaryTextColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: SizedBox(
                child: Text(
                  title,
                  softWrap: true,
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: SizedBox(
                child: Text(
                  desc,
                  softWrap: true,
                  maxLines: 4,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondaryTextColor,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 15,
              ),
              child: Text(
                "Read More -->",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColor.secondaryTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
