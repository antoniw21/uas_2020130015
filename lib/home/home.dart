import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_widget.dart';
import 'me.dart';
import 'movie_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePageWidget(),
    MoviePage(),
    Me(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Confirm Exit?',
          ),
          content: const Text(
              'Are you sure you want to exit the app? Tap \'Yes\' to exit \'No\' to cancel.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // this line exits the app.
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pop(context), // this line dismisses the dialog
              child: const Text(
                'No',
              ),
            )
          ],
        ),
      ).then((value) => value ?? false);
    }
// use .then((value) => value ?? false)

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        // appBar: AppBar(
        //   // leading: IconButton(
        //   //     onPressed: () => onWillPop(), icon: const Icon(Icons.arrow_back)),
        //   title: const Text("Digital Cinema"),
        //   automaticallyImplyLeading: false,
        // ),
        body: Container(
          padding: const EdgeInsets.only(top: 20),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: "Movie",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Me",
            ),
          ],
          selectedItemColor: Colors.red,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}
