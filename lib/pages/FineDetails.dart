import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ActivatePage.dart';
import 'PoliceLogin.dart';

class FineDetails extends StatefulWidget {
  const FineDetails({Key? key}) : super(key: key);

  @override
  _FineDetailsState createState() => _FineDetailsState();
}


class _FineDetailsState extends State<FineDetails> {
  TextEditingController penaltyFeeController = TextEditingController();
  TextEditingController policeIDController = TextEditingController();
  TextEditingController licenseNOController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController vNOController = TextEditingController();
  TextEditingController fineNOController = TextEditingController();

  Map<String, int> penaltyFees = {
    'හඳුනා ගැනීමේ තහඩු': 1000,
    'ආදායම් බලපත්‍රය රැගෙන නොයාම': 2000,
    'මාර්ග නීති වලට අවනත නොවීම': 2000,
    'පසු පසට දිගු දුරක් ධාවනය කිරීම' :1000,
    'දුම් ආදී අධික විමෝචනය' : 1000,
    'දුම් ආදීඅධික විමෝචනය' :1000,
    'වේග සීමා විධිවිධාන උල්ලංඝනය':3000,
    'උපදේශක බල පත්‍රයක් නොමැති වීම': 2000,
    'රියදුරු බලපත්‍රය රැගෙන නොයාම': 1000,

  };

  String selectedTrafficLaw = '';
  int selectedPenaltyFee = 0;
  String selectedDeactivateLicense = '';
  String currentDateTime = '';

  @override
  void initState() {
    super.initState();
    updateDateTime();
  }

  void updateDateTime() {
    DateTime now = DateTime.now();
    currentDateTime = "${"${now.toLocal()}".split(' ')[0]} ${now.hour}:${now.minute}";
  }

  void addData() async {
    dynamic docData = {
      'actstatus': selectedDeactivateLicense,
      'trafficLaw': selectedTrafficLaw,
      'penaltyfee': selectedPenaltyFee,
      'finedateandtime': currentDateTime,
      'policeID': policeIDController.text,
      'licenseNo': licenseNOController.text,
      'locaion': locationController.text,
      'vNo': vNOController.text,
      'fineNO': fineNOController.text,
    };

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('FineDetails').add(docData);

    policeIDController.clear();
    licenseNOController.clear();
    locationController.clear();
    vNOController.clear();
    penaltyFeeController.clear();
    fineNOController.clear();


    setState(() {
      selectedTrafficLaw = '';
      selectedPenaltyFee = 0;
      selectedDeactivateLicense = '';
      updateDateTime();
    });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                child: RichText(
                  text: const TextSpan(
                    text: 'Fine Details',
                    style: TextStyle(
                      fontSize: 27.0,
                      color: Color(0xff020001),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 10),
              Container(
                height: size.height * 0.7,
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
                        icon: Icons.receipt,
                        hintText: 'Enter Fine Number',
                      ),

                      const SizedBox(height: 20),
                      buildTextFieldWithIcon(
                        controller: licenseNOController,
                        icon: Icons.credit_card,
                        hintText: 'Enter License Number',
                      ),
                      const SizedBox(height: 20),
                      buildTextFieldWithIcon(
                        controller: vNOController,
                        icon: Icons.confirmation_number,
                        hintText: 'Enter Vehicle Number',
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
                        controller: locationController,
                        icon: Icons.location_on,
                        hintText: 'Location',
                      ),
                      const SizedBox(height: 10),
                       SingleChildScrollView(
                         child: buildDropdownButton(
                        hintText: 'Violated Traffic Law',
                        items: [
                          'හඳුනා ගැනීමේ තහඩු',
                          'ආදායම් බලපත්‍රය රැගෙන නොයාම',
                          'මාර්ග නීති වලට අවනත නොවීම',
                          'පසු පසට දිගු දුරක් ධාවනය කිරීම',
                          'දුම් ආදී අධික විමෝචනය',
                          'දුම් ආදීඅධික විමෝචනය',
                          'වේග සීමා විධිවිධාන උල්ලංඝනය',
                          'උපදේශක බල පත්‍රයක් නොමැති වීම',
                          'රියදුරු බලපත්‍රය රැගෙන නොයාම',
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            selectedTrafficLaw = value ?? '';
                            selectedPenaltyFee =
                                penaltyFees[selectedTrafficLaw] ?? 0;
                            penaltyFeeController.text =
                                selectedPenaltyFee.toString();
                          });
                        },
                      ),
                  ),

                      const SizedBox(height: 10),
                      buildTextFieldWithIcon(
                        icon: Icons.attach_money,
                        hintText: 'Penalty Fee',
                        controller: penaltyFeeController,
                        enabled: false,
                      ),

                      const SizedBox(height: 20),
                      buildDropdownButton(
                        hintText: 'Deactivate License',
                        items: ['Deactivate'],
                        onChanged: (String? value) {
                          setState(() {
                            selectedDeactivateLicense = value ?? '';
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
                      addData();
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
                          'Done',
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
                          MaterialPageRoute(builder: (_) => PoliceLogin()));
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


              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) =>  const ActivatePage()));
                },

                child: Container(
                  height: 30,
                  width: size.width*0.4,
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