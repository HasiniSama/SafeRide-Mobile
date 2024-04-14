import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:safe_ride_mobile/AllWidgets/progressDialog.dart';
import 'package:safe_ride_mobile/Assitant/assistantMethods.dart';
import 'package:provider/provider.dart';

import '../../providers/location_provider.dart';

class FirebaseAdd extends StatefulWidget {
  const FirebaseAdd({Key? key}) : super(key: key);

  @override
  State<FirebaseAdd> createState() => _FirebaseAddState();
}

class _FirebaseAddState extends State<FirebaseAdd> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();

  Future<void> addButtonPressed(BuildContext context) async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);

    String text1 = textController1.text;
    String text2 = textController2.text;
    String text3 = textController3.text;
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context)
          {
            return ProgressDialog(message: 'Saving Data Please Wait ...',);
          }
      );
      await databaseReference.child('items').push().set({
        'First Name': text1,
        'Median Name': text2,
        'Last Name': text3,
      });
      // String address = await AssistantMethods.searchCordinateAddress(locationProvider.currentPosition!);
      Navigator.pop(context);
      // print(address);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      Navigator.pop(context);
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
              onPressed: () => addButtonPressed(context),
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}