import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

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

    return WillPopScope(
      onWillPop: onWillPop,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: "D",
              style: TextStyle(
                fontSize: 60,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: "C",
                  style: TextStyle(
                    fontSize: 60,
                    color: Color.fromARGB(255, 57, 33, 163),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "\nDIGITAL CINEMA",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30, width: 0),
          Text('Created by Antoni Wijaya - 2020130015'),
        ],
      ),
    );
  }
}
