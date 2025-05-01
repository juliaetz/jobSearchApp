import 'package:flutter/material.dart';

class ProfileSettingsView extends StatelessWidget{
  @override
  _ProfileSettingState createState() => _ProfileSettingState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        // CENTER APPBAR TEXT
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("PROFILE"),
          ],
        ),

        



      ),
    );
  }
}


class _ProfileSettingState extends ProfileSettingsView{

}

