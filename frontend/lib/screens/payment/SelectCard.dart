import 'package:flutter/material.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/buttons.dart';

class SelectCard extends StatefulWidget {
  const SelectCard({
    super.key,
  });

  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  bool waiting = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/paymentBG2.png',
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
                const Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 20),
                  child: Text(
                    'LKR 1000.00',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 325.0,
                  margin: const EdgeInsets.only(top: 60.0, bottom: 10.0),
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Select Existing Card',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 20),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/mastercard.png',
                                  height: 20,
                                ),
                                title: const Text('.... .... .... 4623',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                trailing: Checkbox(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0))),
                                  // Rounded Checkbox
                                  value: waiting,
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      setState(() {
                                        waiting = value;
                                      });
                                    }
                                  },
                                ),
                              )),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/visacard.png',
                                  height: 20,
                                ),
                                title: const Text('.... .... .... 4623',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                trailing: Checkbox(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0))),
                                  // Rounded Checkbox
                                  value: waiting,
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      setState(() {
                                        waiting = value;
                                      });
                                    }
                                  },
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150.0, bottom: 20.0),
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
