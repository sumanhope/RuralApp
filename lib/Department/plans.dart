import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rural/theme/appcolors.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({super.key, required this.role});
  final bool role;
  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  Future errorDialog(String error) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          backgroundColor: AppColor.backgroundColor,
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

  Future addplans() async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseFirestore.instance.collection('plans').doc().set({
        "title": titlecontroller.text,
        "description": descriptioncontroller.text,
      }).then((value) {
        Navigator.pop(context);
        errorDialog("Sucessfully submitted");
        titlecontroller.clear();
        descriptioncontroller.clear();
      });
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      errorDialog(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plans"),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
      ),
      backgroundColor: AppColor.mainCardColor,
      floatingActionButton: widget.role
          ? FloatingActionButton(
              backgroundColor: AppColor.backgroundColor,
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Add Plans',
                          textAlign: TextAlign.center,
                        ),
                        content: SizedBox(
                          height: 150,
                          width: 350,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text("Title"),
                                TextField(
                                  controller: titlecontroller,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Description"),
                                TextField(
                                  controller: descriptioncontroller,
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.iconColor,
                                    ),
                                    onPressed: () {
                                      if (titlecontroller.text.isNotEmpty &&
                                          descriptioncontroller
                                              .text.isNotEmpty) {
                                        addplans();
                                      } else {
                                        errorDialog("Please fill all fields");
                                      }
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.iconColor,
                                    ),
                                    onPressed: () {
                                      titlecontroller.clear();
                                      descriptioncontroller.clear();

                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              },
            )
          : null,
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("plans").snapshots(),
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
                        color: AppColor.iconColor,
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
                return PlanCard(
                  title: docs['title'],
                  description: docs['description'],
                  size: size,
                  date: "11.24.2023",
                  press: () {},
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard({
    Key? key,
    required this.title,
    required this.description,
    required this.press,
    required this.size,
    required this.date,
  }) : super(key: key);
  final String title;
  final String description;
  final VoidCallback press;
  final Size size;
  final String date;
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
                  description,
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
