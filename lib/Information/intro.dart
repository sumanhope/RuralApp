import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  bool showintro = true;
  bool showpop = false;
  bool showcont = false; // Whether to show the text or not

  void toggleintro() {
    setState(() {
      showintro = !showintro;
    });
  }

  void toggkepop() {
    setState(() {
      showpop = !showpop;
    });
  }

  void togglecont() {
    setState(() {
      showcont = !showcont;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 220, 217, 217),
        appBar: AppBar(title: const Text("Intro")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: size.width,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          'images/introimg.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 370,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: toggleintro,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Intro",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_downward),
                          ],
                        ),
                      ),
                    ),
                    if (showintro)
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(1),
                        ),
                        width: 370,
                        height: 520,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Myagde rural municipality has been formed by incorporating Chang, Jamune and Manpang gavis among the former gavis of Tanahun district. There is not much written historical evidence about how the name of this rural municipality came to be 'Magde'."
                            " Magde is the name of a well-known river that starts from Dabhung in Jamune and passes through the boundary line of Chang and Manpang two villages and reaches Dobhan in Shuklagandaki municipality and merges into Seti river. Myagde is the name of a fertile land"
                            " or field in all three villages of Chhang, Manpang and Jamune, therefore it can be assumed that the name of this rural municipality is 'Magde' rural municipality."
                            " A total of 7 wards have been formed by dividing the included villages of Savik. The total area of this rural municipality is 115 square kilometers and it is bordered "
                            "by Beas municipality in the east, Bhimad and Shuklagandaki municipalities in the west, Shuklagandaki and Beas municipalities in the north, Bhimad municipality and Rishing rural municipality in the south."
                            " According to the Central Statistics Department National Census 2068, there are 9886 males and 12616 females out of 5628 households and 22502 total population of this rural municipality.",
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            maxLines: 40,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 370,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: toggkepop,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Population",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_downward),
                          ],
                        ),
                      ),
                    ),
                    if (showpop)
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(1),
                        ),
                        width: 370,
                        height: 120,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Population: 22,502 ",
                                textAlign: TextAlign.left,
                                softWrap: true,
                                maxLines: 10,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Total households: 5,628 ",
                                textAlign: TextAlign.left,
                                softWrap: true,
                                maxLines: 10,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Total male: 9,886 ",
                                textAlign: TextAlign.left,
                                softWrap: true,
                                maxLines: 10,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Total female: 12,616 ",
                                textAlign: TextAlign.left,
                                softWrap: true,
                                maxLines: 10,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 370,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: togglecont,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Contact number",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_downward),
                          ],
                        ),
                      ),
                    ),
                    if (showcont)
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(1),
                        ),
                        width: 370,
                        height: 50,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "065-400108 ",
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            maxLines: 10,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
