import 'package:flutter/material.dart';

class DigitalProfile extends StatefulWidget {
  const DigitalProfile({super.key});

  @override
  State<DigitalProfile> createState() => _DigitalProfileState();
}

class _DigitalProfileState extends State<DigitalProfile> {
  bool ward1 = false;
  bool ward2 = false;
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
      appBar: AppBar(title: const Text("Digital Profile")),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                  total: "3,818",
                  house: '874',
                  male: '1,731',
                  female: '2,087',
                ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                  total: "3,434",
                  house: "887",
                  male: "1,495",
                  female: "1,939",
                ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                  total: "2,586",
                  house: "647",
                  male: "1,190",
                  female: "1,396",
                ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                    total: "3,374",
                    house: "897",
                    male: "1,450",
                    female: "1,924"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                    total: "2,592",
                    house: "602",
                    male: "1,157",
                    female: "1,435"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                    total: "3,343",
                    house: "844",
                    male: "1,440",
                    female: "1,903"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 370,
                height: 60,
                child: ElevatedButton(
                  onPressed: toggleward7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                    total: "3,355",
                    house: "877",
                    male: "1,423",
                    female: "1,932"),
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
    required this.total,
    required this.house,
    required this.male,
    required this.female,
  }) : super(key: key);
  final String total;
  final String house;
  final String male;
  final String female;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(1),
      ),
      width: 370,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Population: $total",
              textAlign: TextAlign.left,
              softWrap: true,
              maxLines: 10,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Total households: $house",
              textAlign: TextAlign.left,
              softWrap: true,
              maxLines: 10,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Total male: $male ",
              textAlign: TextAlign.left,
              softWrap: true,
              maxLines: 10,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Total female: $female",
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
