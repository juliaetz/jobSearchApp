import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/VIEW/darkTheme.dart';

class ProfileSettingsPage extends StatefulWidget {
  ProfileSettingsPage({Key? key}) : super(key: key);


  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}


class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Your Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // PROFILE SECTION
            Container(

              // PROFILE PICTURE
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),

                  SizedBox(height: 20),


                  // NAME
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),

                      // EMAIL
                      Text(
                        'johndoe@example.com',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Divider(),



            // CHANGE PROFILE PICTURE SETTING
            ListTile(
              leading: Icon(Icons.face_retouching_natural),
              title: Text('Change Profile Picture'),
              onTap: () {
                // Setting to change profile picture
              },
            ),



            // TOGGLE DARK MODE SETTING
            SwitchListTile(
              secondary: Icon(Icons.dark_mode),
              title: Text('Dark Mode'),
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleDarkMode(value);
              },
            ),



            // LOG OUT
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                // perform logout
              },
            ),


          ],
        ),
      ),

    );
  }
}



