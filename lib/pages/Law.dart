import 'package:flutter/material.dart';
import 'package:policefinefinal/pages/DriverHomePage.dart';

class LawPage extends StatelessWidget {
  const LawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfff8a102),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  text: 'Law',
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xff020001),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20), // Add space between title and images
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Add your 7 images here
                    Image.network('https://firebasestorage.googleapis.com/v0/b/policefineproject.appspot.com/o/photo1.jpeg?alt=media&token=feb40c46-03cc-4bd7-b76e-3c866702e8e8'),
                    Image.network('https://firebasestorage.googleapis.com/v0/b/policefineproject.appspot.com/o/photo2.jpeg?alt=media&token=55c109d7-a654-4df6-aa03-725d23f7b2fe'),
                    Image.network('https://firebasestorage.googleapis.com/v0/b/policefineproject.appspot.com/o/photo3.jpeg?alt=media&token=49095a47-3f31-43db-9caf-9d5e596ef7fe'),
                    Image.network('https://firebasestorage.googleapis.com/v0/b/policefineproject.appspot.com/o/photo4.jpeg?alt=media&token=8a9abf54-bb31-4fa6-b3a0-ea74ba4ca5cf'),
                    Image.network('https://firebasestorage.googleapis.com/v0/b/policefineproject.appspot.com/o/photo5.jpeg?alt=media&token=163c428b-f27a-4823-a250-400cee707edd'),
                    Image.network('https://firebasestorage.googleapis.com/v0/b/policefineproject.appspot.com/o/photo6.jpeg?alt=media&token=73e071ea-d230-436f-aeec-2c7f82e46a40'),
                    Image.network('https://firebasestorage.googleapis.com/v0/b/policefineproject.appspot.com/o/photo7.jpeg?alt=media&token=efb03b6b-c35d-4e46-8ed9-a443f7e788fe'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) =>  DriverHomePage()));
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
                      'Done',
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
