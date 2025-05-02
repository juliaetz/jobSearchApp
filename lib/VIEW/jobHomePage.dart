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
            SizedBox(height: 20),

            // SOFTWARE ENGINEERING BUTTON
            /*
            ElevatedButton.icon(
              style: ButtonStyle(
                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => )
                  )
                }
              ),

            ),

             */



          ],
        ),

      ),



    );
  }
}

class _JobHomePageState extends JobHomePage{

}