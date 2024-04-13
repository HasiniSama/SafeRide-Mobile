import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseAdd extends StatefulWidget {
  const FirebaseAdd({Key? key}) : super(key: key);

  @override
  State<FirebaseAdd> createState() => _FirebaseAddState();
}

class _FirebaseAddState extends State<FirebaseAdd> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();

  Future<void> addButtonPressed() async {
    String text1 = textController1.text;
    String text2 = textController2.text;
    String text3 = textController3.text;
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    try {
      await databaseReference.child('items').push().set({
        'First Name': text1,
        'Median Name': text2,
        'Last Name': text3,
      });
      Navigator.pop(context);
    } catch (error) {
      print('Error adding data to Firebase: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Connection Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: textController1,
              decoration: InputDecoration(labelText: 'Text Area 1'),
            ),
            TextField(
              controller: textController2,
              decoration: InputDecoration(labelText: 'Text Area 2'),
            ),
            TextField(
              controller: textController3,
              decoration: InputDecoration(labelText: 'Text Area 3'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addButtonPressed,
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}