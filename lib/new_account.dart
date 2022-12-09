import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewAccount extends StatefulWidget {
  const NewAccount({super.key});

  @override
  State<NewAccount> createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            field("Nama Lengkap", name, Icons.person_rounded, null),
            separatorbox(),
            field("Email", email, Icons.email, null),
            separatorbox(),
            field("Password", pass, Icons.lock, null),
            separatorbox(),
            OutlinedButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: pass.text,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
                // Navigator.pop(context);
              },
              child: const Text("Tambah"),
            ),
            separatorbox(),
            Row(
              children: [
                const Text(
                  "Sudah punya akun?",
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget field(String name, TextEditingController controller, IconData icon,
    IconButton? suffixicon) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        labelText: name,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        )),
  );
}

Widget separatorbox() {
  return const SizedBox(
    height: 10,
  );
}

Widget button(String buttonname) {
  return ElevatedButton(
    onPressed: (() {}),
    child: Text(buttonname),
  );
}
