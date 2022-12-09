import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uas_2020130015/booking_confirmation.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Page"),
      ),
      body: Container(
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
                children: [
                  Row(
                    children: [
                      chairButton("1"),
                      chairButton("2"),
                      chairButton("3"),
                      chairButton("4"),
                      chairButton("5"),
                    ],
                  ),
                  Row(
                    children: [
                      chairButton("6"),
                      chairButton("7"),
                      chairButton("8"),
                      chairButton("9"),
                      chairButton("10"),
                    ],
                  ),
                  Row(
                    children: [
                      chairButton("11"),
                      chairButton("12"),
                      chairButton("13"),
                      chairButton("14"),
                      chairButton("15"),
                    ],
                  ),
                  distance(),
                  Row(
                    children: [
                      chairButton("16"),
                      chairButton("17"),
                      chairButton("18"),
                      chairButton("19"),
                      chairButton("20"),
                    ],
                  ),
                  Row(
                    children: [
                      chairButton("21"),
                      chairButton("22"),
                      chairButton("23"),
                      chairButton("24"),
                      chairButton("25"),
                    ],
                  ),
                  Row(
                    children: [
                      chairButton("26"),
                      chairButton("27"),
                      chairButton("28"),
                      chairButton("29"),
                      chairButton("30"),
                    ],
                  ),
                  distance(),
                  Row(
                    children: [
                      chairButton("31"),
                      chairButton("32"),
                      chairButton("33"),
                      chairButton("34"),
                      chairButton("35"),
                    ],
                  ),
                  Row(
                    children: [
                      chairButton("36"),
                      chairButton("37"),
                      chairButton("38"),
                      chairButton("39"),
                      chairButton("40"),
                    ],
                  ),
                  Row(
                    children: [
                      chairButton("41"),
                      chairButton("42"),
                      chairButton("43"),
                      chairButton("44"),
                      chairButton("45"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget chairButton(String text) {
  return ElevatedButton(
    onPressed: () {
      BookingConfirmation(kursi: text);
    },
    // style: ElevatedButton.styleFrom(
    //   fixedSize: Size(1, 1),
    // ),
    child: Text(text),
  );
}

Widget distance() {
  return const SizedBox(height: 30);
}
