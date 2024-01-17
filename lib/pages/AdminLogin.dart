import 'package:flutter/material.dart';
import 'package:policefinefinal/pages/Home.dart';
import 'package:policefinefinal/pages/AdminLogin.dart';
import 'FineDetails.dart';
import 'AdminHome.dart';

class AdminLogin extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  final String _permanentUsername = "Admin";
  final String _permanentPassword = "Admin123";

  AdminLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfff8a102),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18),
          width: size.width,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: RichText(
                    text: const TextSpan(
                      text: 'Admin Login Page',
                      style: TextStyle(
                        fontSize: 27.0,
                        color: Color(0xff020001),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 100),
                Container(
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Positioned(
                        top: 10,
                        left: 20,
                        child: Text(
                          'Login Here',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 20,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.credit_card,
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width: 300,
                                  child: TextFormField(
                                    controller: _idController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your ID number';
                                      }
                                      return null;
                                    },
                                    cursorColor: Colors.grey,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter Your Id Number',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: size.width * .8,
                              child: const Divider(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 120,
                        left: 20,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.password_rounded,
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width: 300,
                                  child: TextFormField(
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    cursorColor: Colors.grey,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      letterSpacing: 1.4,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: size.width * .8,
                              child: const Divider(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 40,
                  right: 30,
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    height: 60,
                    width: 60,
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      String enteredUsername = _idController.text;
                      String enteredPassword = _passwordController.text;

                      if (enteredUsername == _permanentUsername &&
                          enteredPassword == _permanentPassword) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => AdminHome()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid username or password'),
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: size.width * 0.45,
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
