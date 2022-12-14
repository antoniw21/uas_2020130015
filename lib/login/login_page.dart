import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas_2020130015/welcome_screen.dart';

import '../home/home.dart';
import 'new_account.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool noPassword = true;

class _LoginPageState extends State<LoginPage> {
  //initialize  firebase app
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return Future.delayed(
      const Duration(seconds: 3),
      () {
        return firebaseApp;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //yg dlu
        body: FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const Login();
        }
        return const Center(
          child: LoadingScreen(),
        );
      },
    ));
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            separatorbox(),
            separatorbox(),
            mail('Email', email, Icons.email),
            separatorbox(),
            pass(
              'Password',
              password,
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
            button(
              'Login',
              context,
              email,
              password,
            ),
            separatorbox(),
            Row(
              children: [
                const Text("Belum punya akun?",
                    style: TextStyle(color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewAccount(),
                      ),
                    );
                  },
                  child: const Text("Daftar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget pass(String name, TextEditingController controller, IconData icon,
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

Widget mail(
  String name,
  TextEditingController controller,
  IconData icon,
) {
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

Widget button(
  //login
  String buttonname,
  dynamic context,
  TextEditingController emailAddress,
  TextEditingController passwordlogin,
) {
  return ElevatedButton(
    onPressed: (() async {
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress.text,
          password: passwordlogin.text,
        );
        //ke home page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );

        String nn = "";
        User? user = credential.user;
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("users").doc("${user?.uid}").get().then((event) {
          nn = event.get("name");
          print("${event.get("name")}");
        });
        // String name = await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc('${user?.uid}')
        //     .get()
        //     .toString();

        var loginsuccess = SnackBar(content: Text('Hello $nn'));
        ScaffoldMessenger.of(context).showSnackBar(loginsuccess);
      } on FirebaseAuthException catch (e) {
        if (emailAddress.text.isEmpty) {
          const emptyemail =
              SnackBar(content: Text('Email should not empty !'));
          ScaffoldMessenger.of(context).showSnackBar(emptyemail);
        } else if (passwordlogin.text.isEmpty) {
          const emptypassword =
              SnackBar(content: Text('Password should not empty !'));
          ScaffoldMessenger.of(context).showSnackBar(emptypassword);
        } else if (e.code == 'invalid-email') {
          const invalidemail =
              SnackBar(content: Text('Input email correctly !'));
          ScaffoldMessenger.of(context).showSnackBar(invalidemail);
        } else if (e.code == 'user-disabled') {
          const userdisabled =
              SnackBar(content: Text('Input email correctly !'));
          ScaffoldMessenger.of(context).showSnackBar(userdisabled);
        } else if (e.code == 'user-not-found') {
          const usernotfound =
              SnackBar(content: Text('No user found for that email.'));
          ScaffoldMessenger.of(context).showSnackBar(usernotfound);
        } else if (e.code == 'wrong-password') {
          const wrongpassword =
              SnackBar(content: Text('Wrong password provided for that user.'));
          ScaffoldMessenger.of(context).showSnackBar(wrongpassword);
        }
      }
    }),
    child: Text(buttonname),
  );
}
