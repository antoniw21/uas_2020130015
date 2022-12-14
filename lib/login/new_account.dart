import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class NewAccount extends StatefulWidget {
  const NewAccount({super.key});

  @override
  State<NewAccount> createState() => _NewAccountState();
}

bool noPassword = true;

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
            field("Nama Lengkap", name, Icons.person_rounded),
            separatorbox(),
            field("Email", email, Icons.email),
            separatorbox(),
            p(
              "Password",
              pass,
              Icons.lock,
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      noPassword = !noPassword;
                    },
                  );
                },
                icon: noPassword
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
            ),
            separatorbox(),
            OutlinedButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: pass.text,
                  );
                  // buat akun sukses
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Welcome'),
                      content: const Text('A new account has been created'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ));
                          },
                          // onPressed: () => Navigator.pop(context),
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  );
                  FirebaseFirestore db = FirebaseFirestore.instance;

                  // Create a new user with a first and last name
                  final user = <String, dynamic>{
                    "name": name.text,
                    "email": email.text,
                  };

// Add a new document with a generated ID
                  db
                      .collection("users")
                      .doc('${credential.user?.uid}')
                      .set(user);
                  // User? user = credential.user;
                  // await FirebaseFirestore.instance
                  //     .collection('users')
                  //     .doc(user?.uid)
                  //     .set({'email': email.text, 'name': name.text});

                  print('new user created');
                } on FirebaseAuthException catch (e) {
                  if (name.text.isEmpty) {
                    //nama lengkap kosong
                    showDialog<String>(
                      //alert exist email
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Nama Lengkap is empty'),
                        content: const Text('Nama Lengkap should not empty !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else if (email.text.isEmpty || pass.text.isEmpty) {
                    //email + pass kosong
                    showDialog<String>(
                      //alert exist email
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Email or Password is empty'),
                        content:
                            const Text('Email and password should not empty !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }

                  //firebase auth
                  else if (e.code == 'invalid-email') {
                    showDialog<String>(
                      //alert exist email
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Invalid Email Address'),
                        content: const Text('Input email address correctly !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    print('Invalid email address.');
                  } else if (e.code == 'weak-password') {
                    //password at least 6 characters
                    showDialog<String>(
                      //alert password
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Too Weak Password'),
                        content: const Text('Password at least 6 characters !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    showDialog<String>(
                      //alert exist email
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                            'The Account for this email already exist'),
                        content: const Text('Input unique email !'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    print('The account already exists for that email.');
                  } else if (e.code == 'operation-not-allowed') {
                    showDialog<String>(
                      //alert exist email
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Unknown'),
                        content: const Text(
                            'Terjadi kesalahan, silahkan coba lagi.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    print('unknown');
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

Widget p(String name, TextEditingController controller, IconData icon,
    IconButton? suffixicon) {
  return TextField(
    controller: controller,
    obscureText: noPassword,
    decoration: InputDecoration(
        labelText: name,
        prefixIcon: Icon(icon),
        suffixIcon: suffixicon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        )),
  );
}

Widget field(String name, TextEditingController controller, IconData icon) {
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
