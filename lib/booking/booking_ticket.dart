import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:uas_2020130015/booking/description.dart';
import 'package:uas_2020130015/home/home.dart';
import 'package:uas_2020130015/login/login_page.dart';

class BookingTicket extends StatefulWidget {
  const BookingTicket(
      {super.key,
      required this.chair,
      required this.title,
      required this.room,
      required this.clock,
      required this.index,
      required this.boxoffice});

  final int chair;
  final String title;
  final String room;
  final String clock;
  final int index;
  final bool boxoffice;

  @override
  State<BookingTicket> createState() => _BookingTicketState();
}

class _BookingTicketState extends State<BookingTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TicketWidget(
              color: Color.fromARGB(255, 243, 220, 158),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.6,
              isCornerRounded: true,
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Movie Ticket',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //final int chair;
                    // final String title;
                    // final String room;
                    // final String clock;
                    // final int index;
                    // final bool boxoffice;
                    StreamBuilder(
                        stream: widget.boxoffice
                            ? FirebaseFirestore.instance
                                .collection('boxoffice')
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection('films')
                                .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.data == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: Text("${widget.title}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Image.network(
                                        '${streamSnapshot.data?.docs[widget.index]['image']}'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.chair,
                                          color: Colors.green),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${widget.chair}",
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Icon(
                                          Icons.access_time_filled,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text("${widget.clock}"),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Icon(
                                          Icons.room,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text("${widget.room}"),
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            );
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 20),
                      child: Text(
                        'Name : ${u.name}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 20),
                      child: Text(
                        'Email : ${u.email}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              child: Text("Kembali Ke Halaman Utama"))
        ],
      ),
    );
  }
}
