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

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    int pageLength = 5;
    return Container(
      margin: const EdgeInsets.all(15),
      child: SingleChildScrollView(
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
              height: 200,
              child: PageView.builder(
                controller: pageCon,
                itemCount: pageLength,
                itemBuilder: (context, index) {
                  return _pageItem(index, context);
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
            const Text(
              "Other Movies",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 700,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
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
                              'https://firebasestorage.googleapis.com/v0/b/uas-2020130015.appspot.com/o/severance?alt=media&token=16da72c8-80db-453f-8c1c-e0486640ee73'),
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
      ),
    );
  }
}

Widget _pageItem(int index, dynamic context) {
  return Container(
    padding: EdgeInsets.all(10),
    child: IconButton(
      icon: Image.network(
          'https://firebasestorage.googleapis.com/v0/b/uas-2020130015.appspot.com/o/severance?alt=media&token=16da72c8-80db-453f-8c1c-e0486640ee73',
          fit: BoxFit.fill),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DescriptionFilm(),
            ));
      },
    ),
  );
}
