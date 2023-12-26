import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rural/theme/appcolors.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key, required this.role});
  final bool role;
  @override
  State<Emergency> createState() => _DigitalProfileState();
}

class _DigitalProfileState extends State<Emergency> {
  final servicecontroller = TextEditingController();
  final personcontroller = TextEditingController();
  final contactcontroller = TextEditingController();
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

  Future addService() async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseFirestore.instance.collection('services').doc().set({
        "servicename": servicecontroller.text,
        "personname": personcontroller.text,
        "contact": contactcontroller.text,
      }).then((value) {
        Navigator.pop(context);
        errorDialog("Sucessfully submitted");
        servicecontroller.clear();
        personcontroller.clear();
        contactcontroller.clear();
      });
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      errorDialog(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.mainCardColor,
      appBar: AppBar(
        title: const Text("Services"),
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
      ),
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
                        'Add Services',
                        textAlign: TextAlign.center,
                      ),
                      content: SizedBox(
                        height: 250,
                        width: 350,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("Service name"),
                              TextField(
                                controller: servicecontroller,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Person name"),
                              TextField(
                                controller: personcontroller,
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
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.iconColor,
                                  ),
                                  onPressed: () {
                                    if (servicecontroller.text.isNotEmpty &&
                                        personcontroller.text.isNotEmpty &&
                                        contactcontroller.text.isNotEmpty) {
                                      addService();
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
                                    servicecontroller.clear();
                                    personcontroller.clear();

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
                  },
                );
              },
            )
          : null,
      body: SafeArea(
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("services").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
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
                  return Servicecard(
                    size: size,
                    servicename: docs["servicename"],
                    personname: docs["personname"],
                    contact: docs["contact"],
                  );
                }),
              );
            }),
      ),
    );
  }
}

class Servicecard extends StatelessWidget {
  const Servicecard({
    Key? key,
    required this.size,
    required this.servicename,
    required this.personname,
    required this.contact,
  }) : super(key: key);

  final Size size;
  final String servicename;
  final String personname;
  final String contact;
  void _launchPhoneApp(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    ); // Replace with the phone number you want to pre-fill
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      debugPrint('Could not launch phone app');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        height: 120,
        color: AppColor.cardColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    servicename,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    personname,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    contact,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0, right: 15),
              child: IconButton(
                onPressed: () {
                  _launchPhoneApp(contact);
                },
                icon: const Icon(
                  Icons.phone,
                  color: AppColor.iconColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
