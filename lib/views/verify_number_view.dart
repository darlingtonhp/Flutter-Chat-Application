// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_view.dart';

class VerifyNumberView extends StatefulWidget {
  final String verificationID;
  const VerifyNumberView({
    Key? key,
    required this.verificationID,
  }) : super(key: key);

  @override
  State<VerifyNumberView> createState() => _VerifyNumberViewState();
}

class _VerifyNumberViewState extends State<VerifyNumberView> {
  late final TextEditingController smsCodeController;
  User? user;
  @override
  void initState() {
    super.initState();
    smsCodeController = TextEditingController();
  }

  @override
  void dispose() {
    smsCodeController.dispose();
    super.dispose();
  }

  Future<void> verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationID, smsCode: smsCodeController.text);
    await FirebaseAuth.instance.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
      () {
        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.teal,
              content: Text(
                'You are logged in as ${user!.phoneNumber}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.teal,
              content: Text(
                'Verification failed',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Verifying your number'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Waiting to automatically detect an SMS sent to your phone number',
            ),
          ),
          SizedBox(
            width: 150,
            child: TextField(
              controller: smsCodeController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              verifyCode();
            },
            child: const Text('Verify'),
          ),
        ],
      ),
    );
  }
}
