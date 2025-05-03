import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:final_project/VIEW/darkTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingsPage extends StatefulWidget {
  ProfileSettingsPage({Key? key}) : super(key: key);


  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}


class _ProfileSettingsPageState extends State<ProfileSettingsPage> {

  // GET PERMISSION TO ACCESS PHOTOS AND THEN CHANGE PROFILE PICTURE
  File? _profileImage;
  String? _assetProfileImagePath;
  final picker = ImagePicker();


  // KEEP IMAGE ON PROFILE EVERY TIME APP LOADS
  @override
  void initState(){
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async{
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profileImagePath');
    final assetPath = prefs.getString('assetProfileImagePath');

    setState(() {
      if(path != null){
        _profileImage = File(path);
        _assetProfileImagePath = null;
      }
      else if (assetPath != null){
        _assetProfileImagePath = assetPath;
        _profileImage = null;
      }
    });
  }


  // SAVE IMAGE TO PROFILE
  Future<void> _saveProfileImage() async{
    final prefs = await SharedPreferences.getInstance();
    if(_profileImage != null){
      await prefs.setString('profileImagePath', _profileImage!.path);
      await prefs.remove('assetProfileImagePath');
    }
    else if (_assetProfileImagePath != null){
      await prefs.setString('assetProfileImagePath', _assetProfileImagePath!);
      await prefs.remove('profileImagePath');
    }

    if (mounted){
      Future.delayed(Duration(milliseconds: 300), (){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile picture saved!')),
        );
      });
    }
  }


  // SAMPLE IMAGES FOR PROFILE PICTURE
  Future<void> _pickImage() async{
    final sampleImages = [
      'assets/images/burningComputerCat.jpg',
      'assets/images/vacationCat.jpg',
    ];



    // PICK IMAGES FROM GALLERY OR SAMPLE IMAGES
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.all(16),
          height: 250,
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              // OPTION TO ADD FROM GALLERY
              GestureDetector(
                onTap: () async{
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if(pickedFile != null){
                    setState(() {
                      _profileImage = File(pickedFile.path);
                      _assetProfileImagePath = null;
                    });

                    Navigator.pop(context);
                    await _saveProfileImage();
                    await _loadProfileImage();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(
                    child: Icon(Icons.add, size: 40, color: Colors.grey[800]),
                  ),
                ),
              ),


              // SAMPLE IMAGES
              for (var imagePath in sampleImages)
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      _assetProfileImagePath = imagePath;
                      _profileImage = null;
                    });

                    Navigator.pop(context);
                    await _saveProfileImage();
                    await _loadProfileImage();
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      )
                    ),
                  )
                )
            ],
          )
        )
    );
  }



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
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : _assetProfileImagePath != null
                          ? AssetImage(_assetProfileImagePath!) as ImageProvider
                          : AssetImage('assets/avatar.png'),
                    )
                  ),

                  SizedBox(height: 20),


                  ElevatedButton.icon(
                    onPressed: _saveProfileImage,
                    icon: Icon(Icons.save),
                    label: Text('Save profile picture'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    )
                  ),

                  SizedBox(height: 20),



                  // NAME AND EMAIL HARDCODED
                  // IMPLEMENT ONCE THERE'S LOGIN/SIGNUP PAGE
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'FirstName LastName',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'unemployed@gmail.com',
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
              onTap: _pickImage,
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



