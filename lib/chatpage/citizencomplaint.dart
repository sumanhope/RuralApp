import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Complaint"),
        centerTitle: true,
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextField(
                    controller: dateInput,
                    decoration: const InputDecoration(
                      hintText: "yyyy-mm-dd",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).unselectedWidgetColor,
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
                          lastDate: DateTime(2100));

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
                ],
              ),
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
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
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
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labeltext,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: cont,
            decoration: InputDecoration(hintText: hinttext),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
