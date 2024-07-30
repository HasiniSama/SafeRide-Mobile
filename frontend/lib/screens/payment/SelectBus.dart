import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/buttons.dart';
import 'package:safe_ride_mobile/widgets/inputField.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

class SelectBus extends StatefulWidget {
  const SelectBus({
    super.key,
  });

  @override
  State<SelectBus> createState() => _SelectBusState();
}

class _SelectBusState extends State<SelectBus> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController1 = TextEditingController();

  void showAlert(BuildContext context, String title, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushNamed(context, '/payment');
        // Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void startOneTimePayment(BuildContext context) async {
    Map paymentObject = {
      "sandbox": false, // true if using Sandbox Merchant ID
      "merchant_id": "1227711", // Replace your Merchant ID
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "item_number_1": "001",
      "item_name_1": "Test Item #1",
      "amount_1": "5.00",
      "quantity_1": "2",
      "item_number_2": "002",
      "item_name_2": "Test Item #2",
      "amount_2": "20.00",
      "quantity_2": "1",
      "amount": 30.00,
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "delivery_address": "No. 46, Galle road, Kalutara South",
      "delivery_city": "Kalutara",
      "delivery_country": "Sri Lanka",
      "custom_1": "",
      "custom_2": ""
    };

    PayHere.startPayment(paymentObject, (paymentId) {
      print("One Time Payment Success. Payment Id: $paymentId");
      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
    }, (error) {
      print("One Time Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("One Time Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/paymentBG1.png',
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: appColors.kBlue2,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          size: 40.0,
                          color: appColors.kBlue2,
                        ),
                      ),
                    ),
                  ],
                ),
                const BusProfileCard(
                  url: 'assets/childProfile.jpg',
                ),
                Container(
                  width: 325.0,
                  margin: const EdgeInsets.only(top: 60.0, bottom: 10.0),
                  padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomInputField(
                        controller: _firstNameController,
                        labelText: 'Bus Name',
                        exampleText: 'Bus Name',
                      ),
                      CustomInputField(
                        controller: _lastNameController,
                        labelText: 'Driver Mobile Number',
                        exampleText: 'Driver Mobile Number',
                      ),
                      CustomInputField(
                        controller: _addressController1,
                        labelText: 'Owner Mobile Number',
                        exampleText: 'Owner Mobile Number',
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 325.0,
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomInputField(
                        controller: _firstNameController,
                        labelText: 'Monthly Payment',
                        exampleText: 'LKR 1000.00',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0, bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      startOneTimePayment(context);
                    },
                    style: AppButtonsStyle.blueButtonStyle,
                    child: const Text('Pay',
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
