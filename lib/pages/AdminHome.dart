import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:policefinefinal/pages/AdminLogin.dart';

class AdminHome extends StatelessWidget {
  AdminHome({Key? key}) : super(key: key);

  final TextEditingController _policeIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  void _clearFields() {
    _policeIdController.clear();
    _passwordController.clear();
  }

  Future<void> _addOrUpdateDataToFirebase(bool isUpdate) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String policeId = _policeIdController.text;
    String newPassword = _passwordController.text;

    if (policeId.isNotEmpty && newPassword.isNotEmpty) {
      if (isUpdate) {
        QuerySnapshot querySnapshot = await firestore
            .collection('RegisterPolice')
            .where('policeIidNO', isEqualTo: policeId)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          String docId = querySnapshot.docs.first.id;
          await firestore
              .collection('RegisterPolice')
              .doc(docId)
              .update({'policepassword': newPassword});
          print('Police record updated successfully.');
        } else {
          print('Police ID not found.');
        }
      } else {
        dynamic docData = {
          'policeIidNO': policeId,
          'policepassword': newPassword,
        };
        await firestore.collection('RegisterPolice').add(docData);
        print('Police record added successfully.');
      }
      _clearFields();
    } else {
      print('Police ID or password is empty.');
    }
  }

  Future<void> _deleteDataFromFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String policeId = _policeIdController.text;

    if (policeId.isNotEmpty) {
      QuerySnapshot querySnapshot = await firestore
          .collection('RegisterPolice')
          .where('policeIidNO', isEqualTo: policeId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;
        await firestore.collection('RegisterPolice').doc(docId).delete();
        print('Police record deleted successfully.');
      } else {
        print('Police ID not found.');
      }
      _clearFields();
    } else {
      print('Police ID is empty.');
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
                    text: 'Police Register',
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
                height: size.height * 0.35,
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
                        'Register Here',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      left: 20,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: 300,
                                child: TextField(
                                  controller: _policeIdController,
                                  cursorColor: Colors.grey,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter Police ID',
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
                      top: 180,
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
                    Positioned(
                      bottom: -30,
                      right: 30,
                      child: Container(
                        padding: const EdgeInsets.all(22),
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _addOrUpdateDataToFirebase(false);
                    },
                    child: Container(
                      width: size.width * 0.3,
                      height: 30,
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Center(
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      _addOrUpdateDataToFirebase(true); // Update
                    },
                    child: Container(
                      width: size.width * 0.3,
                      height: 30,
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Center(
                        child: Text(
                          'Update',
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
              const SizedBox(height: 50),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _deleteDataFromFirebase();
                    },
                    child: Container(
                      width: size.width * 0.3,
                      height: 30,
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => AdminLogin()));
                    },
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
                          'Logout',
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
            ],
          ),
        ),
      ),
    );
  }
}
