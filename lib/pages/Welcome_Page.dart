import 'package:flutter/material.dart';
import 'package:policefinefinal/pages/AdminLogin.dart';
import 'Home.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfff8a102),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    'assets/front.jpg',
                    height: 200,
                    width: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WELCOME',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 60),
                        Text(
                          'SMART TRAFFIC FINE SYSTEM',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Towards a Peaceful environment to',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'live with confidence, without fear',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'of Crime and Violence.',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Home()),
                    );
                  },
                  child: Center(
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
                          'Continue >>>',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) =>  AdminLogin()),
                    );
                  },
                  child: Center(
                    child: Container(
                      height: 30,
                      width: size.width * 0.3,
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Center(
                        child: Text(
                          'Admin >>>',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
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
