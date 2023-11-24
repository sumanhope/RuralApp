import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rural/theme/appcolors.dart';

class EmploymentPage extends StatefulWidget {
  const EmploymentPage({super.key, required this.role});
  final bool role;
  @override
  State<EmploymentPage> createState() => _EmploymentPageState();
}

class _EmploymentPageState extends State<EmploymentPage> {
  final jobtitlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final contactcontroller = TextEditingController();

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

  Future addemployment() async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseFirestore.instance.collection('employment').doc().set({
        "jobtitle": jobtitlecontroller.text,
        "description": descriptioncontroller.text,
        "location": locationcontroller.text,
        "contact": contactcontroller.text,
      }).then((value) {
        Navigator.pop(context);
        errorDialog("Sucessfully submitted");
        jobtitlecontroller.clear();
        descriptioncontroller.clear();
        locationcontroller.clear();
        contactcontroller.clear();
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
        title: const Text("Employment"),
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
      ),
      backgroundColor: AppColor.mainCardColor,
      floatingActionButton: widget.role
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Add Employment',
                          textAlign: TextAlign.center,
                        ),
                        content: SizedBox(
                          height: 300,
                          width: 350,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text("Job Title"),
                                TextField(
                                  controller: jobtitlecontroller,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Description"),
                                TextField(
                                  controller: descriptioncontroller,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Location"),
                                TextField(
                                  controller: locationcontroller,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Contact no"),
                                TextField(
                                  controller: contactcontroller,
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
                                    onPressed: () {
                                      if (jobtitlecontroller.text.isNotEmpty &&
                                          descriptioncontroller
                                              .text.isNotEmpty &&
                                          locationcontroller.text.isNotEmpty &&
                                          contactcontroller.text.isNotEmpty) {
                                        addemployment();
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
                                    onPressed: () {
                                      jobtitlecontroller.clear();
                                      descriptioncontroller.clear();
                                      locationcontroller.clear();
                                      contactcontroller.clear();
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
            stream:
                FirebaseFirestore.instance.collection("employment").snapshots(),
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
                  return EmploymentCard(
                    jobtitle: docs['jobtitle'],
                    description: docs['description'],
                    location: docs['location'],
                    contact: docs['contact'],
                    imagelink: docs['imagelink'],
                    size: size,
                    press: () {},
                  );
                }),
              );
            }),
      ),
    );
  }
}

class EmploymentCard extends StatelessWidget {
  const EmploymentCard({
    Key? key,
    required this.jobtitle,
    required this.description,
    required this.press,
    required this.location,
    required this.contact,
    required this.size,
    required this.imagelink,
  }) : super(key: key);
  final String jobtitle;
  final String description;
  final String location;
  final String contact;
  final VoidCallback press;
  final String imagelink;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 10),
      child: InkWell(
        onTap: press,
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imagelink),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        jobtitle,
                        softWrap: true,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: Text(
                        description,
                        softWrap: true,
                        maxLines: 5,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          color: AppColor.textColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColor.fillColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.place,
                            color: AppColor.iconColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          location,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColor.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColor.fillColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.phone,
                            color: AppColor.iconColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          contact,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColor.secondaryTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
