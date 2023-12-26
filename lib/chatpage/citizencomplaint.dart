import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rural/theme/appcolors.dart';

class CitizenComplaint extends StatefulWidget {
  const CitizenComplaint({super.key});

  @override
  State<CitizenComplaint> createState() => _CitizenComplaintState();
}

class _CitizenComplaintState extends State<CitizenComplaint> {
  final fullnamecontroller = TextEditingController();
  final dateInput = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final complainttypecontroller = TextEditingController();
  final desiredoutcome = TextEditingController();

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

  Future submitcomplaint() async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseFirestore.instance.collection('complaint').doc().set({
        "fullname": fullnamecontroller.text,
        "description": descriptioncontroller.text,
        "date": dateInput.text,
        "type": complainttypecontroller.text,
        "outcome": desiredoutcome.text
      }).then((value) {
        Navigator.pop(context);
        errorDialog("Sucessfully submitted");
        fullnamecontroller.clear();
        descriptioncontroller.clear();
        dateInput.clear();
        complainttypecontroller.clear();
        desiredoutcome.clear();
      });
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      errorDialog(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainCardColor,
      appBar: AppBar(
        title: const Text("New Complaint"),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ComplainFields(
              labeltext: "Fullname",
              hinttext: "Ram",
              cont: fullnamecontroller,
            ),
            ComplainFields(
              labeltext: "Description",
              hinttext: "Detailed explaination of incident ",
              cont: descriptioncontroller,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: AppColor.textColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 10,
                  ),
                  child: TextField(
                    controller: dateInput,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColor.backgroundColor,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColor.iconColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColor.iconColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(1),
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: AppColor.iconColor,
                      ),
                    ),
                    style: const TextStyle(
                      color: AppColor.textColor,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        // print(
                        //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        // print(
                        //     formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                ),
              ],
            ),
            ComplainFields(
              labeltext: "Complaint Type",
              hinttext: "Harresment",
              cont: complainttypecontroller,
            ),
            ComplainFields(
              labeltext: "Desired Outcome",
              hinttext: "Disciplinary actions",
              cont: desiredoutcome,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (fullnamecontroller.text.isNotEmpty &&
                        descriptioncontroller.text.isNotEmpty &&
                        dateInput.text.isNotEmpty &&
                        complainttypecontroller.text.isNotEmpty &&
                        desiredoutcome.text.isNotEmpty) {
                      submitcomplaint();
                    } else {
                      errorDialog("Please fill all fields");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.iconColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComplainFields extends StatelessWidget {
  const ComplainFields({
    Key? key,
    required this.labeltext,
    required this.hinttext,
    required this.cont,
  }) : super(key: key);
  final String labeltext;
  final String hinttext;
  final TextEditingController cont;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Text(
              labeltext,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
            ),
            child: SizedBox(
              child: TextField(
                controller: cont,
                cursorColor: AppColor.iconColor,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColor.backgroundColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: AppColor.iconColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: AppColor.iconColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(1),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
