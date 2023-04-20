import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notice"),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 220, 217, 217),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("notice").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something is wrong"),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.find_in_page,
                      size: 50,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "No Data found",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.green,
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
  }) : super(key: key);
  final String title;
  final String date;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 370,
        //height: 220,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(180, 191, 240, 231),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.newspaper,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 19.0, top: 10, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      title,
                      softWrap: true,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      desc,
                      softWrap: true,
                      maxLines: 10,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
