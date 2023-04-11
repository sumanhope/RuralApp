import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

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
    return Scaffold(
      appBar: AppBar(title: const Text("Plans")),
      backgroundColor: const Color.fromARGB(255, 220, 217, 217),
      floatingActionButton: FloatingActionButton(
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
                              onPressed: () {
                                if (titlecontroller.text.isNotEmpty &&
                                    descriptioncontroller.text.isNotEmpty) {
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
      ),
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
                return PlanCard(
                  title: docs['title'],
                  description: docs['description'],
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
  }) : super(key: key);
  final String title;
  final String description;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: press,
        child: Container(
          width: 370,
          height: 150,
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
                    Icons.description,
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
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        description,
                        softWrap: true,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
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
