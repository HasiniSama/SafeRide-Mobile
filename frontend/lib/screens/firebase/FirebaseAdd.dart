import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:safe_ride_mobile/AllWidgets/progressDialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import '../../providers/location_provider.dart';

class FirebaseAdd extends StatefulWidget {
  const FirebaseAdd({Key? key}) : super(key: key);

  @override
  State<FirebaseAdd> createState() => _FirebaseAddState();
}

class _FirebaseAddState extends State<FirebaseAdd> {
  Future<void> addButtonPressed(BuildContext context) async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: 'Saving Data Please Wait ...');
        },
      );

      // Load the JSON file
      String jsonString = await rootBundle.loadString('lib/data/schools.json');
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Upload data to Firebase Realtime Database
      jsonData.forEach((district, schools) async {
        await databaseReference.child('schoolsBaseOnDistricts').child(district).set({
          'schools': schools
        });
      });

      Navigator.pop(context);
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => addButtonPressed(context),
              child: Text('Upload JSON Data to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}
