import 'package:flutter/material.dart';
import 'package:policefinefinal/pages/DriverHomePage.dart';
import 'PoliceLogin.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold
      (
        backgroundColor: const Color(0xfff8a102),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(18),
                height: size.height,
                width: size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 160,
                        child: RichText(
                            text: const TextSpan(
                              text: 'Are You...',
                              style: TextStyle(
                                fontSize: 32,
                                color: Color(0xff020001),
                                fontWeight: FontWeight.bold,

                              ),
                            )),
                      ),


                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) =>  PoliceLogin()));
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
                              'Police Officer',
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
                              MaterialPageRoute(builder: (_) => DriverHomePage()));
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
                              'Driver',
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

