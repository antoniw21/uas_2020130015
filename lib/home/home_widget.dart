import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130015/description.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  PageController pageCon = PageController();

  double currentPageValue = 0.0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPageValue < 5) {
        currentPageValue++;
      } else {
        currentPageValue = 0;
      }

      pageCon.animateToPage(currentPageValue.round(),
          duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
    });
    pageCon.addListener(() {
      setState(() {
        currentPageValue = pageCon.page!;
      });
    });
  }

  @override
  void dispose() {
    //ketika pindah page ga di aktifkan - hemat memori
    pageCon.dispose();
    super.dispose();
    timer.cancel();
  }

  double pageviewheight = 200;

  @override
  Widget build(BuildContext context) {
    int pageLength = 5;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Box Office",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: pageviewheight,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('films').snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return PageView.builder(
                      controller: pageCon,
                      itemCount: pageLength,
                      itemBuilder: (context, index) {
                        //_CastError (type '_JsonQueryDocumentSnapshot' is not a subtype of type 'List<dynamic>' in type cast)

                        // List films = streamSnapshot.data?.docs[index] as List;
                        // List boxofficefilms = films
                        //     .where((element) => element['rating'] > 8)
                        //     .toList();
                        // print(boxofficefilms);
                        // print(boxofficefilms[index]);
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            icon: Image.network(
                                '${streamSnapshot.data?.docs[index]['image']}',
                                fit: BoxFit.fill),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DescriptionFilm(),
                                  ));
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Center(
              child: DotsIndicator(
                dotsCount: pageLength,
                position: currentPageValue,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
              width: 0,
            ),
            const Text(
              "Other Movies",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height / 2,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('films').snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: streamSnapshot.data?.docs.length,
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
                                    '${streamSnapshot.data?.docs[index]['image']}'),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
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
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
