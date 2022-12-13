import 'package:flutter/material.dart';
import 'package:uas_2020130015/booking_page.dart';

class DescriptionFilm extends StatefulWidget {
  const DescriptionFilm({super.key});

  @override
  State<DescriptionFilm> createState() => _DescriptionFilmState();
}

class _DescriptionFilmState extends State<DescriptionFilm> {
  double imageHeight = 250;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Film Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //gambar
              width: double.maxFinite,
              height: imageHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/batman.jpeg',
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - imageHeight,
              padding: const EdgeInsets.all(20),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          // judul utama
                          "Batman : Unmask The Truth",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        separatorBox(),
                        Row(
                          //rating dan jumlah org
                          children: [
                            Wrap(
                              children: List.generate(
                                5,
                                (index) {
                                  return const Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Colors.green,
                                  );
                                },
                              ),
                            ),
                            spaceBox(),
                            addText("4.7"),
                            spaceBox(),
                            addText("1256 people")
                          ],
                        ),
                        separatorBox(),
                        Row(
                          //genre dan jam tayang
                          children: [
                            iconText(
                                Icons.local_movies, Colors.orange, "Action"),
                            spaceBox(),
                            spaceBox(),
                            iconText(Icons.access_time, Colors.red, "2 hours"),
                          ],
                        ),
                        separatorBox(),
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        separatorBox(),
                        const Text(
                          //desc
                          "Take a look at more new footage from the vigilante, crime fighter feature 'The Batman', directed by Matt Reeves, starring Robert Pattinson as 'Bruce Wayne' /'Batman, with Zoë Kravitz, Paul Dano, Jeffrey Wright, John Turturro, Peter Sarsgaard, Barry Keoghan, Jayme Lawson, Andy Serkis and Colin Farrell, opening in theaters March 4, 2022.",
                          style: TextStyle(
                            wordSpacing: 1.5,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "Added to favorite",
                                ),
                                action: SnackBarAction(
                                  label: "Undo",
                                  onPressed: () {},
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.favorite),
                              spaceBox(),
                              const Text("Add to favorite"),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(),
                              ),
                            );
                          },
                          child: const Text("Booking Now"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,

Widget separatorBox() {
  return const SizedBox(
    height: 10,
  );
}

Widget iconText(IconData icon, Color color, String text) {
  return Row(
    children: [
      Icon(icon, color: color),
      const SizedBox(
        width: 10,
      ),
      addText(text),
    ],
  );
}

Widget addText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
    ),
  );
}

Widget spaceBox() {
  return const SizedBox(
    width: 10,
  );
}
