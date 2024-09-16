import 'package:arama_app/pages/arama_home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String surname, password;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Giriş',
                        style: TextStyle(
                            fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Image.asset(
                        'assets/dgnlogo.png',
                        height: 200,
                      ),

                      /* CircleAvatar(
                        // backgroundImage: const AssetImage('assets/karatay_bldysi.jpg'),
                        radius: 100,
                      )*/
                      const SizedBox(height: 30),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Bu alanı eksiksiz doldurunuz';
                          } else {}
                        },
                        onSaved: (value) {
                          surname = value!;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Kullanıcı Adı',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Bu alanı eksiksiz doldurunuz';
                          } else {}
                        },
                        onSaved: (value) {
                          password = value!;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Şifre',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: signIn,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.grey.shade300,
                          backgroundColor: const Color(0xFF0E1C36),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          minimumSize: const Size(double.infinity, 25),
                        ),
                        child: const Text(
                          'Giriş Yap',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 20),
                      /*ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/registerPage'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF0E1C36),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          minimumSize: const Size(double.infinity, 25),
                        ),
                        child: const Text(
                          'Kayıt Ol',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }
}
