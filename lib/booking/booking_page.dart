import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uas_2020130015/booking/description.dart';

import 'booking_ticket.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.title});

  final String title;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} Booking Page"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chairs').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              // decoration: const BoxDecoration(
              //   color: Colors.amber,
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: const BoxDecoration(color: Colors.black),
                    child: const Center(
                      child: Text(
                        "Layar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            chairButton(
                                0, streamSnapshot, context, widget.title),
                            chairButton(
                                1, streamSnapshot, context, widget.title),
                            chairButton(
                                2, streamSnapshot, context, widget.title),
                            chairButton(
                                3, streamSnapshot, context, widget.title),
                            chairButton(
                                4, streamSnapshot, context, widget.title),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            chairButton(
                                5, streamSnapshot, context, widget.title),
                            chairButton(
                                6, streamSnapshot, context, widget.title),
                            chairButton(
                                7, streamSnapshot, context, widget.title),
                            chairButton(
                                8, streamSnapshot, context, widget.title),
                            chairButton(
                                9, streamSnapshot, context, widget.title),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            chairButton(
                                10, streamSnapshot, context, widget.title),
                            chairButton(
                                11, streamSnapshot, context, widget.title),
                            chairButton(
                                12, streamSnapshot, context, widget.title),
                            chairButton(
                                13, streamSnapshot, context, widget.title),
                            chairButton(
                                14, streamSnapshot, context, widget.title),
                          ],
                        ),
                        distance(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            chairButton(
                                15, streamSnapshot, context, widget.title),
                            chairButton(
                                16, streamSnapshot, context, widget.title),
                            chairButton(
                                17, streamSnapshot, context, widget.title),
                            chairButton(
                                18, streamSnapshot, context, widget.title),
                            chairButton(
                                19, streamSnapshot, context, widget.title),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            chairButton(
                                20, streamSnapshot, context, widget.title),
                            chairButton(
                                21, streamSnapshot, context, widget.title),
                            chairButton(
                                22, streamSnapshot, context, widget.title),
                            chairButton(
                                23, streamSnapshot, context, widget.title),
                            chairButton(
                                24, streamSnapshot, context, widget.title),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            chairButton(
                                25, streamSnapshot, context, widget.title),
                            chairButton(
                                26, streamSnapshot, context, widget.title),
                            chairButton(
                                27, streamSnapshot, context, widget.title),
                            chairButton(
                                28, streamSnapshot, context, widget.title),
                            chairButton(
                                29, streamSnapshot, context, widget.title),
                          ],
                        ),
                        distance(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            chairButton(
                                30, streamSnapshot, context, widget.title),
                            chairButton(
                                31, streamSnapshot, context, widget.title),
                            chairButton(
                                32, streamSnapshot, context, widget.title),
                            chairButton(
                                33, streamSnapshot, context, widget.title),
                            chairButton(
                                34, streamSnapshot, context, widget.title),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            chairButton(
                                35, streamSnapshot, context, widget.title),
                            chairButton(
                                36, streamSnapshot, context, widget.title),
                            chairButton(
                                37, streamSnapshot, context, widget.title),
                            chairButton(
                                38, streamSnapshot, context, widget.title),
                            chairButton(
                                39, streamSnapshot, context, widget.title),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            chairButton(
                                40, streamSnapshot, context, widget.title),
                            chairButton(
                                41, streamSnapshot, context, widget.title),
                            chairButton(
                                42, streamSnapshot, context, widget.title),
                            chairButton(
                                43, streamSnapshot, context, widget.title),
                            chairButton(
                                44, streamSnapshot, context, widget.title),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Widget chairButton(int number, AsyncSnapshot<QuerySnapshot> streamSnapshot,
    context, String title) {
  int x = 0;
  while (streamSnapshot.data?.docs[x].id != title) {
    x++;
  }
  List<dynamic> cek = [];
  cek = streamSnapshot.data?.docs[x]['chair'];

  return ElevatedButton(
    onPressed: cek[number]
        ? null
        : () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  'Confirm Booking?',
                ),
                content: Text(
                    'Are you sure you want to book chair at number ${number + 1}?\n\nTap \'Yes\' to book \'No\' to cancel.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      FirebaseFirestore db = FirebaseFirestore.instance;

                      cek[number] = true;

                      final update = <String, dynamic>{
                        "chair": cek,
                      };

                      db
                          .collection("chairs")
                          .doc('${title}')
                          .set(update, SetOptions(merge: true));

                      var a = SnackBar(
                          content: Text(
                              'You have booked chair at number ${number + 1}'));
                      ScaffoldMessenger.of(context).showSnackBar(a);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingTicket(
                              chair: number + 1,
                              title: title,
                              room: "${streamSnapshot.data?.docs[x]['room']}",
                              clock: "${streamSnapshot.data?.docs[x]['clock']}",
                              index: selected.getIndex,
                              boxoffice: selected.getBoxoffice,
                            ),
                          ));
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(
                        context), // this line dismisses the dialog
                    child: const Text(
                      'No',
                    ),
                  )
                ],
              ),
            ).then((value) => value ?? false);
          },
    // style: ElevatedButton.styleFrom(
    //   fixedSize: Size(1, 1),
    // ),
    child: Text('${number + 1}'),
  );
}

Widget distance() {
  return const SizedBox(height: 30);
}
