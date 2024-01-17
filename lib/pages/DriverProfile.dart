import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:policefinefinal/pages/DriverHomePage.dart';


class DriverProfile extends StatefulWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  _DriverProfileState createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {

  TextEditingController licenseNOController = TextEditingController();
  TextEditingController statusController = TextEditingController();



  void searchFine() async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('FineDetails')
        .where('licenseNo', isEqualTo: licenseNOController.text)
        .orderBy('finedateandtime', descending: true)
        .limit(1)
        .get()
    ;
    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          // status = doc["actstatus"];
          statusController.text = doc["actstatus"];
        });
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfff8a102),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18),
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 230,
                  child: RichText(
                    text: const TextSpan(
                      text: 'License Status',
                      style: TextStyle(
                        fontSize: 27.0,
                        color: Color(0xff020001),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                Container(
                  height: size.height * 0.25,
                  width: size.width * 1.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        buildTextFieldWithIcon(
                          controller: licenseNOController,
                          icon: Icons.person,
                          hintText: 'Enter license Number',
                        ),
                       //  const SizedBox(height: 20),
                       // // Container(child: Text(status),
                       // ),
                    const SizedBox(height: 20),
                    buildTextFieldWithIcon(
                        controller: statusController,
                        icon: Icons.person,
                        hintText: 'Your Status',)
                      ],
                      ),
                    ),
                  ),


                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 5.0),

                    GestureDetector(
                      onTap: () {
                        searchFine();
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
                            'Search',
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
                            MaterialPageRoute(builder: (_) => DriverHomePage()));
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



            ]
            ),
          ),
        ),
        ),
      );
  }

  Widget buildTextFieldWithIcon({
    required IconData icon,
    required String hintText,
    TextEditingController? controller,
    bool enabled = true,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enabled,
            cursorColor: Colors.grey,
            style: const TextStyle(
              color: Colors.black54,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownButton({
    required String hintText,
    required List<String> items,
    void Function(String?)? onChanged,
  }) {
    return Row(
      children: [
        const Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
            ),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
