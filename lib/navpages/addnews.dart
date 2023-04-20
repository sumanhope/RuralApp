import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNews extends StatefulWidget {
  const AddNews({super.key});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  final titlecontroller = TextEditingController();
  final descontroller = TextEditingController();
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
        "description": descontroller.text,
        "date": datecontroller.text,
      }).then((value) {
        Navigator.pop(context);
        errorDialog("Sucessfully submitted");
        titlecontroller.clear();
        descontroller.clear();
        datecontroller.clear();
      });
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      errorDialog(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add News/Notice")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "News Title",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: titlecontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  // <-- SEE HERE
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: descontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Date",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: datecontroller,
                  decoration: const InputDecoration(
                    hintText: "yyyy-mm-dd",
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
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
                          DateFormat('yyyy-MM-dd').format(pickedDate);
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
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (titlecontroller.text.isNotEmpty &&
                            descontroller.text.isNotEmpty &&
                            datecontroller.text.isNotEmpty) {
                          addnotice();
                        } else {
                          errorDialog("Please fill all fields");
                        }
                      },
                      child: const Text("Submit"),
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
