import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      body: Container(),
    );
  }
}
