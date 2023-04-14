import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rural/landingpage.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final titlecontroller = TextEditingController();
  final datecontroller = TextEditingController();

  final User user = FirebaseAuth.instance.currentUser!;
  String _uid = " ";
  bool isAdmin = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _uid = user.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      isAdmin = userDoc.get('isAdmin');
    });
  }

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

  Future addnotice() async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseFirestore.instance.collection('notice').doc().set({
        "title": titlecontroller.text,
        "date": datecontroller.text,
      }).then((value) {
        Navigator.pop(context);
        errorDialog("Sucessfully submitted");
        titlecontroller.clear();
        datecontroller.clear();
      });
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      errorDialog(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notice"),
          centerTitle: true,
        ),
        backgroundColor: const Color.fromARGB(255, 220, 217, 217),
        floatingActionButton: isAdmin
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Add Notice',
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
                                  const Text("Notice Title"),
                                  TextField(
                                    controller: titlecontroller,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text("Date"),
                                  TextField(
                                    controller: datecontroller,
                                    decoration: const InputDecoration(
                                      hintText: "yyyy-mm-dd",
                                      suffixIcon: Icon(Icons.calendar_today),
                                    ),
                                    readOnly: true,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        // print(
                                        //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        // print(
                                        //     formattedDate); //formatted date output using intl package =>  2021-03-16
                                        setState(() {
                                          datecontroller.text =
                                              formattedDate; //set output date to TextField value.
                                        });
                                      } else {}
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                        if (titlecontroller.text.isNotEmpty &&
                                            datecontroller.text.isNotEmpty) {
                                          addnotice();
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
                                        titlecontroller.clear();
                                        datecontroller.clear();
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
            stream: FirebaseFirestore.instance.collection("notice").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
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
                    date: docs['date'],
                    press: () {},
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Noticecard extends StatelessWidget {
  const Noticecard({
    Key? key,
    required this.title,
    required this.date,
    required this.press,
  }) : super(key: key);
  final String title;
  final String date;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: press,
        child: Container(
          width: 370,
          height: 120,
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
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.newspaper,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19.0),
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
      ),
    );
  }
}
