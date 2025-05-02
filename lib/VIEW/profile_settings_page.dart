import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatelessWidget{
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: <Widget>[
            Text("Your Profile"),
          ],

        ),
      ),
    );
  }
}

class _ProfileSettingsPageState {
}


