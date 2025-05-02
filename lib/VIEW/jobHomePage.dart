import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/VIEW/dataScienceJobsPage.dart';
import 'package:final_project/VIEW/softwareEngJobsPage.dart';
import 'package:final_project/VIEW/profile_settings_page.dart';
import 'package:final_project/VIEW/darkTheme.dart';

class JobHomePage extends StatelessWidget {
  JobHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to your Job Search!"),
          ],
        ),
      ),


      // TEXT "WHERE WOULD YOU LIKE TO START"
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 95, horizontal: 55),
            child: Text(
              "Where would you like to start?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),


          // BUTTON TO GO TO SOFTWARE ENGINEER PAGE
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SoftwareEngJobsPage()));
            },
            icon: Icon(Icons.call_merge_outlined),
            label: Text(
              "Find a Software Engineering Job!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
            ),
          ),

          SizedBox(height: 50),



          // BUTTON TO GO TO DATA SCIENCE PAGE
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DataScienceJobsPage()));
            },
            icon: Icon(Icons.cable_sharp),
            label: Text(
              "Find a Data Science Job!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
            ),
          ),

          SizedBox(height: 110),



          // BUTTON TO GO TO PROFILE AND SETTINGS PAGE
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileSettingsPage(), // Optional: pass dark mode props if needed
                ),
              );
            },
            icon: Icon(Icons.face_retouching_natural_outlined),
            label: Text(
              "Profile and Settings",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),

          SizedBox(height: 90),



          // DATASET CREDITS
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(
              "Software Engineering dataset by: Emre Öksüz",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(
              "Data Science dataset by: Hummaam Qaasim",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),


        ],
      ),


    );
  }
}
