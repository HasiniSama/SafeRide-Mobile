import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/buttons.dart';
import 'package:safe_ride_mobile/widgets/inputField.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';

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
                      // Add your button's functionality here
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
