import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uas_2020130015/booking/booking_ticket.dart';
import 'package:uas_2020130015/booking/description.dart';

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Tickets",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .collection('tickets')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.data?.docs.length == 0) {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.38),
                    child: const Text(
                      "Data kosong",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ));
                } else if (streamSnapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.88,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: streamSnapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingTicket(
                                      chair: streamSnapshot.data?.docs[index]
                                          ['chair'],
                                      title: streamSnapshot.data?.docs[index]
                                          ['title'],
                                      room: streamSnapshot.data?.docs[index]
                                          ['room'],
                                      clock: streamSnapshot.data?.docs[index]
                                          ['clock'],
                                      index: streamSnapshot.data?.docs[index]
                                          ['indexpic'],
                                      boxoffice: streamSnapshot
                                          .data?.docs[index]['boxoffice']),
                                ));
                          },
                          child: Row(
                            children: [
                              // Container(
                              //   margin: const EdgeInsets.only(bottom: 5),
                              //   height: 100,
                              //   width: 100,
                              //   child: Image.network(
                              //       '${streamSnapshot.data?.docs[index]['image']}'),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(30),
                              //   ),
                              // ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text(
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    '${streamSnapshot.data?.docs[index]['title']}',
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
