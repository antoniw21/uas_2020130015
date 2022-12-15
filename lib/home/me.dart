import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../login/login_page.dart';

class Me extends StatefulWidget {
  const Me({super.key});

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  final ImagePicker imagePicker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            ElevatedButton(
                onPressed: () => pickImage(ImageSource.gallery),
                child: Text("Ubah Foto Profile")),
            separatorBox(),
            separatorBox(),
            identity(Icons.person, u.getName),
            separatorBox(),
            identity(Icons.email, u.getEmail),
            separatorBox(),
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

  pickImage(ImageSource source) async {
    XFile? xFileImage = await imagePicker.pickImage(source: source);
    if (xFileImage != null) {
      image = File(xFileImage.path);
      setState(() {});
    }
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
