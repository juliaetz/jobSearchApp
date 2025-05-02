import 'package:final_project/VIEW/dataScienceJobsPage.dart';
import 'package:final_project/VIEW/softwareEngJobsPage.dart';
import 'package:final_project/VIEW/profile_settings_page.dart';
import 'package:flutter/material.dart';

class JobHomePage extends StatelessWidget{
  @override
  _JobHomePageState createState() => _JobHomePageState();

  @override
  Widget build(BuildContext context){
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


      body: Container(
        child: Column(
          children: [
            // TEXT "WHERE WOULD YOU LIKE TO START?"
            Padding(
              padding: EdgeInsets.symmetric(vertical: 95, horizontal: 55),
              child: Text(
                "Where would you like to start?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),


            // SOFTWARE ENGINEERING BUTTON
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SoftwareEngJobsPage()));
              },
              icon: Icon(Icons.call_merge_outlined),
              label: Text(
                  "Find a Software Engineering Job!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green[900],
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



            // DATA SCIENCE BUTTON
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DataScienceJobsPage()));
              },
              icon: Icon(Icons.cable_sharp),
              label: Text(
                "Find a Data Science Job!",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green[900],
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


            // PROFILE AND SETTINGS BUTTON
            ElevatedButton.icon(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSettingsPage()));
              },
              icon: Icon(Icons.face_retouching_natural_outlined),
              label: Text(
                "Profile and Settings",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.green[900],
                ),
              ),
            ),

            SizedBox(height: 90),



            // CREDIT DATASETS
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                "Software Engineering dataset by: Emre Öksüz",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                "Data Science dataset by: Hummaam Qaasim",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),


          ],
        ),
      ),



    );
  }
}


class _JobHomePageState extends JobHomePage{

}