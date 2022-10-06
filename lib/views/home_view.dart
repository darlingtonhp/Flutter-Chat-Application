import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? get userPhoneNumber => FirebaseAuth.instance.currentUser?.phoneNumber;
  late final TextEditingController _messageText;
  @override
  void initState() {
    super.initState();
    _messageText = TextEditingController();
  }

  @override
  void dispose() {
    _messageText.dispose();
    super.dispose();
  }

//  This method is used to get one time data

//   Future<void> getMessages() async {
//     final messages =
//         await FirebaseFirestore.instance.collection('messages').get();
//     for (var message in messages.docs) {
//       print(message.data());
//     }
//   }

// This method is used to get data eachn time it changes by subscribing to the stream
// we are constantly listening to data changes.

  //  ====>Future<void> getMessageSnapshots() async {
  //   await for (var snapshot
  //       in FirebaseFirestore.instance.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
              );
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
        centerTitle: true,
        title: const Text('Talk App'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs;
                  List<Text> messageWigdets = [];
                  for (var message in messages) {
                    final messageText = message['text'];
                    final messageSender = message['sender'];
                    final messageWigdet =
                        Text('$messageText from $messageSender');
                    messageWigdets.add(messageWigdet);
                  }
                  return Column(
                    children: [...messageWigdets],
                  );
                }
                return const CircularProgressIndicator.adaptive();
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageText,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('messages')
                          .add(
                        {
                          'text': _messageText.text,
                          'sender': userPhoneNumber,
                        },
                      );
                    },
                    child: const Text(
                      'Send',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
