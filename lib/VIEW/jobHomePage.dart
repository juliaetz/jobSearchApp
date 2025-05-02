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
              padding: EdgeInsets.symmetric(vertical: 100, horizontal: 55),
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
              onPressed: () {},
              icon: Icon(Icons.call_merge_outlined),
              label: Text(
                  "Find a Software Engineering Job!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green[900],
                  ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
            ),

            SizedBox(height: 50),


            // DATA SCIENCE BUTTON
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.cable_sharp),
              label: Text(
                "Find a Data Science Job!",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green[900],
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
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