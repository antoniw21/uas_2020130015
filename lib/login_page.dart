import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uas_2020130015/home.dart';
import 'package:uas_2020130015/new_account.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const Login();
        }
        return const Center(
          child: HomePage(),
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
    return Container(
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
          button('Login', context),
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
) {
  return ElevatedButton(
    onPressed: (() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    }),
    child: Text(buttonname),
  );
}
