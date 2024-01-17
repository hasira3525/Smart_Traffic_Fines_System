import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:policefinefinal/pages/Home.dart';
import 'package:policefinefinal/pages/Welcome_Page.dart';

class ActivatePage extends StatefulWidget {
  const ActivatePage({Key? key}) : super(key: key);

  @override
  _ActivatePageState createState() => _ActivatePageState();
}

class _ActivatePageState extends State<ActivatePage> {
  TextEditingController policeIDController = TextEditingController();
  TextEditingController fineNOController = TextEditingController();
  TextEditingController licenseNOController = TextEditingController();
  TextEditingController receiptNOController = TextEditingController();
  TextEditingController totalPenaltyFeeController = TextEditingController();

  String selectedActivateLicense = '';
  late String currentDateTime;

  @override
  void initState() {
    super.initState();
    updateDateTime();
  }

  void updateDateTime() {
    DateTime now = DateTime.now();
    currentDateTime = "${now.toLocal()}".split(' ')[0] + " ${now.hour}:${now.minute}";
  }

  void addData() async {
    Map<String, dynamic> docData = {
      'actstatus': selectedActivateLicense,
      'finedateanditme': currentDateTime,
      'policeID': policeIDController.text,
      'licenseNo': licenseNOController.text,
      'receiptNO': receiptNOController.text,
      'fineNO': fineNOController.text,
    };

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('FineDetails').add(docData);

    policeIDController.clear();
    licenseNOController.clear();
    receiptNOController.clear();
    fineNOController.clear();

    setState(() {
      selectedActivateLicense = '';
      updateDateTime();
    });
  }

  void updateData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('FineDetails')
        .where('fineNO', isEqualTo: fineNOController.text)
        .get();

    querySnapshot.docs.forEach((doc) async {
      await doc.reference.update({
        'actstatus': selectedActivateLicense,
        'finedateanditme': currentDateTime,
        'policeID': policeIDController.text,
        'licenseNo': licenseNOController.text,
        'receiptNO': receiptNOController.text,
      });

      policeIDController.clear();
      licenseNOController.clear();
      receiptNOController.clear();
      fineNOController.clear();

      setState(() {

        selectedActivateLicense = '';
        updateDateTime();
      });
    });
  }
  void calculateTotalPenaltyFee(String id) async {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('FineDetails')
        .where('actstatus', isEqualTo: 'Deactivate')
        .where('licenseNo',isEqualTo: id)
        .get();

    int totalPenaltyFee = 0;

    querySnapshot.docs.forEach((doc) {
      totalPenaltyFee += (int.parse(doc['penaltyfee'].toString()) ?? 0)!!;
      setState(() {
        totalPenealty = totalPenaltyFee;
      });
    });


    print('Total Penalty Fee for Deactivate status: $totalPenaltyFee');

  }

  int totalPenealty = 0;



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
                      text: 'Activation Page',
                      style: TextStyle(
                        fontSize: 27.0,
                        color: Color(0xff020001),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                Container(
                  height: size.height * 0.63,
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
                  child: SingleChildScrollView(
                  child: Padding(

                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        buildTextFieldWithIcon(
                          controller: policeIDController,
                          icon: Icons.person,
                          hintText: 'Police Officer Id',
                        ),
                        const SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          controller: fineNOController,
                          icon: Icons.credit_card,
                          hintText: 'Enter Fine Number',
                        ),

                        const SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          controller: licenseNOController,
                          icon: Icons.credit_card,
                          hintText: 'Enter License Number',
                        ),
                        const SizedBox(height: 10),
                        buildTextFieldWithIcon(
                          icon: Icons.access_time,
                          hintText: 'Current Date and Time',
                          controller: TextEditingController(text: currentDateTime),
                          enabled: false,
                        ),
                        const SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          controller: receiptNOController,
                          icon: Icons.receipt,
                          hintText: 'Receipt Number',
                        ),
                        const SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          controller: totalPenaltyFeeController,
                          icon: Icons.attach_money,
                          hintText: totalPenealty.toString(),

                        ),

                        const SizedBox(height: 20),
                        buildDropdownButton(
                          hintText: 'Activate License',
                          items: ['Activate'],
                          onChanged: (String? value) {
                            setState(() {
                              selectedActivateLicense = value ?? '';
                            });
                          },

                        ),
                        const SizedBox(height: 20),

                      ],
                    ),
                    ),

                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 0),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        updateData();
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
                            'Activate',
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
                        setState(() {
                          calculateTotalPenaltyFee(licenseNOController.text) ;
                        });

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
                  ],
                ),


                const SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => WelcomePage()));
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
