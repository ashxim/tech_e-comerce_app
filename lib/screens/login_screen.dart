import 'package:flutter/material.dart';
import 'package:my_ecomerce_app/component/background.dart';
import 'package:my_ecomerce_app/constants/themes.dart';
import 'package:my_ecomerce_app/screens/Register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: screenWidth * 0.95,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  border: Border.all(
                    color: Colors.grey.shade600,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail or Username',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: screenWidth * 0.95,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  border: Border.all(
                    color: Colors.grey.shade600,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: !passwordVisible,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 180, top: 2),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forget your password ?',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 136, 34),
                  minimumSize: const Size(320, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  signIn();
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 120, top: 10),
                child: Row(
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
