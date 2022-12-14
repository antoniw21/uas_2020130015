import 'package:flutter/material.dart';
import 'package:uas_2020130015/description.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => MoviePageState();
}

class MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Favorite"),
                ),
              ),
              spaceBox(),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("History"),
                ),
              ),
            ],
          ),
          Container(
            height: 540,
            child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DescriptionFilm(),
                        ));
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        height: 100,
                        width: 100,
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/uas-2020130015.appspot.com/o/Black%20Bird?alt=media&token=47af3e56-3990-465d-ade4-3ebbb6e70dd6'),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: const Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "Batman : Unmask The Truth",
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget spaceBox() {
  return const SizedBox(
    width: 10,
  );
}
