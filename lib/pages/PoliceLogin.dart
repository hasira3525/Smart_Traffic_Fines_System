import 'package:flutter/material.dart';
import 'package:policefinefinal/pages/FineDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'DriverHomePage.dart';

class PoliceLogin extends StatelessWidget {
  final TextEditingController _policeIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    try {
      String policeID = _policeIDController.text.trim();
      String password = _passwordController.text.trim();


      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('RegisterPolice')
          .where('policeIidNO', isEqualTo: policeID)
          .where('policepassword', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FineDetails()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Invalid police ID or password'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfff8a102),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18),
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 220,
                child: RichText(
                  text: const TextSpan(
                    text: 'Police Login',
                    style: TextStyle(
                      fontSize: 32,
                      color: Color(0xff020001),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Container(
                height: size.height * 0.27,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Positioned(
                      top: 10,
                      left: 120,
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
                                child: TextField(
                                  controller: _policeIDController,
                                  cursorColor: Colors.grey,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter Police ID Number',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            width: size.width * 0.8,
                            child: const Divider(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: 130,
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
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  cursorColor: Colors.grey,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
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
                            width: size.width * 0.8,
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
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  _login(context);
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
    );
  }
}
