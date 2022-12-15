import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/selected_movie.dart';
import 'booking_page.dart';

class DescriptionFilm extends StatefulWidget {
  const DescriptionFilm(
      {Key? key, required this.index, required this.boxoffice})
      : super(key: key);

  final int index;
  final bool boxoffice;

  @override
  State<DescriptionFilm> createState() => _DescriptionFilmState();
}

SelectedMovie selected = SelectedMovie();

class _DescriptionFilmState extends State<DescriptionFilm> {
  double imageHeight = 300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Film Detail'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: widget.boxoffice
              ? FirebaseFirestore.instance.collection('boxoffice').snapshots()
              : FirebaseFirestore.instance.collection('films').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: [
                  Container(
                    //gambar
                    width: double.maxFinite,
                    height: imageHeight,
                    child: Image.network(
                      '${streamSnapshot.data?.docs[widget.index]['image']}',
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
                            Text(
                              // judul utama
                              '${streamSnapshot.data?.docs[widget.index]['title']}',
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
                                addText(//rating
                                    '${streamSnapshot.data?.docs[widget.index]['rating']}/10'),
                                spaceBox(),
                                spaceBox(),
                                iconText(
                                    Icons.person,
                                    Colors.orange, //genre
                                    '${streamSnapshot.data?.docs[widget.index]['vote']} votes'),
                              ],
                            ),
                            separatorBox(),
                            Row(
                              //genre dan jam tayang
                              children: [
                                iconText(
                                    Icons.local_movies,
                                    Colors.orange, //genre
                                    '${streamSnapshot.data?.docs[widget.index]['genre']}'),
                                spaceBox(),
                                spaceBox(),
                                iconText(
                                    //duretion
                                    Icons.access_time,
                                    Colors.red,
                                    '${streamSnapshot.data?.docs[widget.index]['time']} min'),
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
                            Text(
                              //description
                              '${streamSnapshot.data?.docs[widget.index]['desc']}',
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
                                      onPressed: () {
                                        int fav = widget.index;
                                      },
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
                                selected.setIndex = widget.index;
                                selected.setBoxoffice = widget.boxoffice;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingPage(
                                        title:
                                            '${streamSnapshot.data?.docs[widget.index]['title']}'),
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
              );
            }
          },
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
