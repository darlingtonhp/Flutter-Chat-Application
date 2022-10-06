import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talkapp/views/verify_number_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _countryCode;
  late final TextEditingController _phoneNumber;
  String verificationID = '';
  @override
  void initState() {
    super.initState();
    _countryCode = TextEditingController(text: '27');
    _phoneNumber = TextEditingController(text: '616701403');
  }

  @override
  void dispose() {
    _countryCode.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  Future<void> verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+${_countryCode.text}${_phoneNumber.text}',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // await FirebaseAuth.instance.signInWithCredential(credential).then(
        //       (value) => ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(
        //           backgroundColor: Colors.teal,
        //           content: Text(
        //             'Verification Successful',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //       ),
        //     );
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid phone number')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.teal,
              content: Text(
                e.message.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          verificationID = verificationId;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyNumberView(
              verificationID: verificationID,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Enter your phone number',
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text('Talk App will need to verify your phone number.'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    child: TextField(
                      controller: _countryCode,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '+',
                        hintText: '263',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    child: TextField(
                      controller: _phoneNumber,
                      textAlign: TextAlign.center,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'phone number',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Text('Carrier charges may apply'),
          const Spacer(),
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () {
                  verifyPhoneNumber();
                },
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
