import 'package:final_project/VIEW/jobInfo_component.dart';
import 'package:final_project/PRESENTER/jobInfo_presenter.dart';
import 'package:final_project/VIEW/locations_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/VIEW/DATA_SCIENCE/dataScienceJobsPage.dart';
import 'package:final_project/VIEW/SOFTWARE_ENG/softwareEngJobsPage.dart';
import 'package:final_project/VIEW/darkTheme.dart';
import 'package:final_project/VIEW/careergoals_view.dart';

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
            Text("Welcome to the Job Search!"),
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


          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  // BUTTON TO JOB INFO PAGE
                  child: ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => JobInfoPage(BasicJobInfoPresenter(), title: 'INFO', key: const Key('INFO'))));
                      },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    icon: Icon(Icons.mail),
                    label: Text("More Job Info", style: TextStyle(fontSize: 15)),
                  ),
                ),

                SizedBox(width: 15),


                Expanded(
                  //Button to do to the career goals page
                  child: ElevatedButton.icon(
                    //Currently goes to the settings page as a placeholder CHANGE WHEN CAREER GOALS PAGE IS FUNCTIONAL
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CareerGoalsPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      label: Text(
                        "Career Goals",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      icon: Icon(Icons.work_outline_outlined)
                  ),

                ),
              ],
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

          SizedBox(height: 45),



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
