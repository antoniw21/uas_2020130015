import 'package:flutter/material.dart';

class BookingConfirmation extends StatefulWidget {
  const BookingConfirmation({super.key, required String kursi});

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmation"),
      ),
      body: Container(),
    );
  }
}
