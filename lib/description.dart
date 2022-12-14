import 'package:flutter/material.dart';
import 'package:uas_2020130015/booking_page.dart';

class DescriptionFilm extends StatefulWidget {
  const DescriptionFilm({super.key});

  @override
  State<DescriptionFilm> createState() => _DescriptionFilmState();
}

class _DescriptionFilmState extends State<DescriptionFilm> {
  double imageHeight = 300;
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
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/uas-2020130015.appspot.com/o/Bullet%20Train?alt=media&token=d1c68037-dc6c-404d-bdeb-1d118c8963f4',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height - imageHeight,
              padding: const EdgeInsets.all(20),
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
                          iconText(Icons.local_movies, Colors.orange, "Action"),
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
                        "Phenomenal. Absolutely a movie that will stand the test of time of being one of the best superhero movies ever made. Top 3 already for me. And I can already see it staying as my favorite movie of the year. Holy shit is this movie flat out amazing. Honestly I haven’t seen a movie this stylish pulled off efficiently in a long time. Some movies do create a mood and have cool camera techniques but sometimes those movies don’t really gel well enough with the actual story. Or knows how to fit it with the narrative. A lot of movies have great style but for me this is a great example of how a director and his team knows a perfect balance. Matt Reeves and his team knocked this one out of the park and did not let up. It is that good. To me this is just behind The Dark Knight but it is real close. But in further rewatches it might actually be better. The fight scenes are better, the overall mode is handled better, to me certain aspects heighten this movie to be almost the best Batman movie and best superhero movie ever made. However, this is a flat out epic. With sweeping music, a complex story spanning across multiple characters, and an ending that really makes you feel a weight has been lifted off of you. Because we have been put through hell and when this movie ends it certainly made me believe in The Batman. We love this character and it wasn’t till the end is where he finally becomes The Batman. No offense to Marvel but it did take them like 6 movies of Spider-Man to finally have Spider-Man. Here we did it in one movie. I love it.",
                        // "Take a look at more new footage from the vigilante, crime fighter feature 'The Batman', directed by Matt Reeves, starring Robert Pattinson as 'Bruce Wayne' /'Batman, with Zoë Kravitz, Paul Dano, Jeffrey Wright, John Turturro, Peter Sarsgaard, Barry Keoghan, Jayme Lawson, Andy Serkis and Colin Farrell, opening in theaters March 4, 2022.",
                        style: TextStyle(
                          wordSpacing: 1.5,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  separatorBox(),
                  separatorBox(),
                  separatorBox(),
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
