import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_ecomerce_app/component/background.dart';
import 'package:my_ecomerce_app/constants/themes.dart';
import 'package:my_ecomerce_app/screens/login_screen.dart';
import 'package:my_ecomerce_app/widgets/btmnavbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVis = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      _confirmPasswordController.dispose();
    }

    bool passwordConfirmed() {
      if (_confirmPasswordController.text.trim() ==
          _passwordController.text.trim()) {
        return true;
      } else {
        return false;
      }
    }

    Future signUp() async {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BtmNavBar(),
            ));
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Background(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  width: screenWidth * 0.95,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(
                      color: Colors.grey.shade600, // Border color
                      width: 1.0,
                      // Border width
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                        border: InputBorder.none, // Hide the default border
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 55,
                  width: screenWidth * 0.95,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(
                      color: Colors.grey.shade600, // Border color
                      width: 1.0,
                      // Border width
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !passwordVis,

                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(passwordVis
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              passwordVis = !passwordVis;
                            });
                          },
                        ),
                      ),
                      keyboardType: TextInputType
                          .visiblePassword, // Hide the default border
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 55,
                  width: screenWidth * 0.95,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(
                      color: Colors.grey.shade600, // Border color
                      width: 1.0,
                      // Border width
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: !passwordVis,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(passwordVis
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              passwordVis = !passwordVis;
                            });
                          },
                        ), // Hide the default border
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 136, 34),
                      minimumSize: const Size(320, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    signUp();
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100, top: 10),
                  child: Row(
                    children: [
                      const Text("Already Have an Account?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      TextButton(
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()))
                              },
                          child: const Text('Sign in',
                              style: TextStyle(
                                fontSize: 16,
                              )))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
