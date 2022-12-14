import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130015/user_login.dart';

import '../login/login_page.dart';

class Me extends StatefulWidget {
  const Me({super.key});

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            const Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: "D",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "C",
                    style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 57, 33, 163),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "\nDIGITAL CINEMA",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            separatorBox(),
            separatorBox(),
            const CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage("assets/images/noprofile.jpeg"),
            ),
            separatorBox(),
            separatorBox(),
            identity(Icons.person, u.getName),
            separatorBox(),
            identity(Icons.email, u.getEmail),
            separatorBox(),
            OutlinedButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
                await FirebaseAuth.instance.signOut();
                const logoutsuccess =
                    SnackBar(content: Text('Successfully log out'));
                ScaffoldMessenger.of(context).showSnackBar(logoutsuccess);
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}

Widget separatorBox() {
  return const SizedBox(
    height: 10,
  );
}

Widget identity(IconData icon, String text) {
  return TextField(
    readOnly: true,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      hintText: text,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );
}
