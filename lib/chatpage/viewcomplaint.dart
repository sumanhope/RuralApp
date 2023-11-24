import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rural/theme/appcolors.dart';

class ViewComplaint extends StatefulWidget {
  const ViewComplaint({super.key});

  @override
  State<ViewComplaint> createState() => _ViewComplaintState();
}

class _ViewComplaintState extends State<ViewComplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Complaint"),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("complaint").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something is wrong"),
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
                  return ComplainCard(
                    fullname: docs["fullname"],
                    description: docs["description"],
                    date: docs["date"],
                    type: docs["type"],
                    outcome: docs["outcome"],
                    press: () {},
                  );
                }),
              );
            }),
      ),
    );
  }
}

class ComplainCard extends StatelessWidget {
  const ComplainCard({
    Key? key,
    required this.fullname,
    required this.description,
    required this.date,
    required this.press,
    required this.outcome,
    required this.type,
  }) : super(key: key);
  final String fullname;
  final String description;
  final String date;
  final String outcome;
  final String type;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: press,
        child: Container(
          width: 370,
          decoration: BoxDecoration(
            color: AppColor.cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
              top: 20,
              bottom: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reported By: $fullname",
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColor.textColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: Text(
                    "Description: $description",
                    softWrap: true,
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColor.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Type: $type",
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColor.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: Text(
                    "Desired Outcome: $outcome",
                    softWrap: true,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColor.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
