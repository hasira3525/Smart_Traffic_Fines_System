import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'DriverHomePage.dart';
import 'package:firebase_database/firebase_database.dart';

class VerifyPolice extends StatefulWidget {

  VerifyPolice({Key? key}) : super(key: key);

  @override
  State<VerifyPolice> createState() => _VerifyPoliceState();
}

class _VerifyPoliceState extends State<VerifyPolice> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _policeIDNumberController = TextEditingController();
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Verify Police Officer',
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Color(0xff020001),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),


                  const SizedBox(height: 30),
                  Container(
                    height: size.height * 0.15,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: const EdgeInsets.all(20),
                    width: size.width,
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
                            'Verify Here',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
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
                                      controller: _policeIDNumberController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Police ID number';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.grey,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter Police Id Number',
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


              Container(
                height: 250,
                width: MediaQuery.of(context).size.height *
                    MediaQuery.of(context).size.width *
                    20.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(imagelink!),
                    fit: BoxFit.cover,
                ),
                ),
              ),



                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: () {
                      getImageLink(_policeIDNumberController.text);
                      print(imagelink);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DriverHomePage()));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? imagelink  = "https://firebasestorage.googleapis.com/v0/b/policefineproject.appspot.com/o/6998114.png?alt=media&token=e12a089c-6e3d-4634-9c7c-45f34830cc7e";

  void getImageLink(String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('verifyPolice')
        .where('policeIDNumber', isEqualTo: id)
        .get();
    imagelink = querySnapshot.docs[0]['imageLink'].toString();

  }
}
