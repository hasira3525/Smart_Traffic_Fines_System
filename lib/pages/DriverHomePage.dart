import 'package:flutter/material.dart';
import 'package:policefinefinal/pages/Law.dart';
import 'package:policefinefinal/pages/Welcome_Page.dart';
import 'DriverProfile.dart';
import 'VerifyPolice.dart';

class DriverHomePage extends StatelessWidget {
  const DriverHomePage({Key? key}) : super(key: key);

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
                        width: 200,
                        child: RichText(
                          text: const TextSpan(
                            text: 'Driver Homepage',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xff020001),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 100),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) =>   DriverProfile()));
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),

                          child: const Center(
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => LawPage()));
                        },

                        child: Container(
                          height: 50,
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),

                          child: const Center(
                            child: Text(
                              'Law',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) =>VerifyPolice()));
                        },

                        child: Container(
                          height: 50,
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),

                          child: const Center(
                            child: Text(
                              'Verify Police Officer',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => WelcomePage()));
                        },

                        child: Container(
                          height: 50,
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),

                          child: const Center(
                            child: Text(
                              'Home',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                )
            )
        )
    );
  }
}
