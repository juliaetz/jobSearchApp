import 'package:final_project/PRESENTER/locations_presenter.dart';
import 'package:final_project/VIEW/jobInfo_component.dart';
import 'package:final_project/PRESENTER/jobInfo_presenter.dart';
import 'package:final_project/VIEW/locations_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/VIEW/DATA_SCIENCE/dataScienceJobsPage.dart';
import 'package:final_project/VIEW/SOFTWARE_ENG/softwareEngJobsPage.dart';
import 'package:final_project/VIEW/darkTheme.dart';

import '../PRESENTER/jobInfo_presenter.dart';
import 'account_screens/profile_settings_page.dart';


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

          SizedBox(height: 20),



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

          SizedBox(height: 55),


          // GO TO LOCATIONS PAGE (OR JOB INFO PAGE? WHICHEVER ONE FIRST?)
          ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => JobInfoPage(BasicJobInfoPresenter(), title: 'INFO', key: const Key('INFO')),
                //builder: (context) => JobInfoPage(JobInfoPresenter(), key: key, title: "Job Information"),
              ));
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            child: Text(
              "FIND MORE JOB INFO HERE!",
              style: TextStyle(fontSize: 15),
            )
          ),

          SizedBox(height: 90),



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

          SizedBox(height: 20),


          // TEMPORARY BUTTON TO SIGN OUT
          ElevatedButton.icon(
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/signin',
                    (Route<dynamic> route) => false,
              );
              // Optionally, navigate back to the login screen or perform other actions
            },
            icon: Icon(Icons.logout),
            label: Text(
              "Sign Out",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
          ),


          SizedBox(height: 50),



          // DATASET CREDITS
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              "Software Engineering dataset by: Emre Öksüz",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
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
