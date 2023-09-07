import 'package:flutter/material.dart';

class Representatives extends StatefulWidget {
  const Representatives({super.key});

  @override
  State<Representatives> createState() => _RepresentativesState();
}

class _RepresentativesState extends State<Representatives> {
  bool ward1 = true;
  bool ward2 = true;
  bool ward3 = false;
  bool ward4 = false;
  bool ward5 = false;
  bool ward6 = false;
  bool ward7 = false;
  // Whether to show the text or not
  void toggleward1() {
    setState(() {
      ward1 = !ward1;
    });
  }

  void toggleward2() {
    setState(() {
      ward2 = !ward2;
    });
  }

  void toggleward3() {
    setState(() {
      ward3 = !ward3;
    });
  }

  void toggleward4() {
    setState(() {
      ward4 = !ward4;
    });
  }

  void toggleward5() {
    setState(() {
      ward5 = !ward5;
    });
  }

  void toggleward6() {
    setState(() {
      ward6 = !ward6;
    });
  }

  void toggleward7() {
    setState(() {
      ward7 = !ward7;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 217, 217),
      appBar: AppBar(title: const Text("Representatives")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward1,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ward 1",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                ),
              ),
              if (ward1)
                const DigitalCard(
                  chairman: "Mani Bhadra Vagle",
                  member: 'Min Bahadur Gurung, Min Bahadur Thapa ',
                  femalemem: 'Ram Maya Thapa Khadul Magar',
                  dalitfem: 'Keshari Sunar',
                ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward2,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ward 2",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                ),
              ),
              if (ward2)
                const DigitalCard(
                  chairman: "Shiv Bahadur Chettri",
                  member: "Mahendra Bahadur Ranabhat, Ramesh Chhetri",
                  femalemem: "Sita Kumal",
                  dalitfem: "Kalpana Pariyar",
                ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward3,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ward 3",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                ),
              ),
              if (ward3)
                const DigitalCard(
                  chairman: "Tuk raj Adhikari",
                  member: "Prakash Ghimire, Bal Chandra Ghimire ",
                  femalemem: "Janaki Thapa",
                  dalitfem: "Sunita Nepali",
                ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward4,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ward 4",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                ),
              ),
              if (ward4)
                const DigitalCard(
                    chairman: "Dipak Kumar Shrestha",
                    member: "Dol Bahadur Sunar, Bam Bahadur Masrangi",
                    femalemem: "Badrika Bhattarai",
                    dalitfem: "Shree Maya Nepali"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward5,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ward 5",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                ),
              ),
              if (ward5)
                const DigitalCard(
                    chairman: "Shiv Bahadur Ale",
                    member: "Lokendra Gurung, Khima Nand Wagle",
                    femalemem: "Chini Maya Thapa",
                    dalitfem: "Sabita B.K"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward6,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ward 6",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                ),
              ),
              if (ward6)
                const DigitalCard(
                    chairman: "Hari Lal Gurung",
                    member: "Buddhi Bahadur Thapa, Bhagat Bahadur Thapa",
                    femalemem: "Anu Mahat Shrestha",
                    dalitfem: "Vishnu Maya Koirala"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward7,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ward 7",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                ),
              ),
              if (ward7)
                const DigitalCard(
                    chairman: "Basanta Kumar Shrestha",
                    member: "Laxman Gharti, Dhurva Bahadur Nepali",
                    femalemem: "Keshi Maya Magar",
                    dalitfem: "Ful Maya Nepali"),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DigitalCard extends StatelessWidget {
  const DigitalCard({
    Key? key,
    required this.chairman,
    required this.member,
    required this.femalemem,
    required this.dalitfem,
  }) : super(key: key);
  final String chairman;
  final String member;
  final String femalemem;
  final String dalitfem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(1),
      ),
      width: 370,
      height: 160,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chairman: $chairman",
              textAlign: TextAlign.left,
              softWrap: true,
              maxLines: 10,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "Female member: $femalemem ",
              textAlign: TextAlign.left,
              softWrap: true,
              maxLines: 10,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "Dalit women member: $dalitfem",
              textAlign: TextAlign.left,
              softWrap: true,
              maxLines: 10,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "Members: $member",
              textAlign: TextAlign.left,
              softWrap: true,
              maxLines: 10,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
