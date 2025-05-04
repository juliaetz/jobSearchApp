import 'dart:io';
import 'package:final_project/VIEW/account_screens/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/VIEW/darkTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth_gate.dart';
import '../../account_firebase_logic.dart' as fire_base_logic;

class ProfileSettingsPage extends StatefulWidget {
  ProfileSettingsPage({Key? key}) : super(key: key);


  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}


class _ProfileSettingsPageState extends State<ProfileSettingsPage> {

  // GET PERMISSION TO ACCESS PHOTOS AND THEN CHANGE PROFILE PICTURE
  File? _profileImage;
  String? _profileImageUrl;
  String? _assetProfileImagePath;


  // KEEP IMAGE ON PROFILE EVERY TIME APP LOADS
  @override
  void initState(){
    super.initState();
    _loadProfileImage();
    _fetchCurrentUser();
  }


  // SAVE IMAGE TO PROFILE
  Future<void> _saveProfileImage() async{
    final prefs = await SharedPreferences.getInstance();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid == null) return;

    if(_assetProfileImagePath != null){
      final userDocRef = await fire_base_logic.getUserDocument();
      await userDocRef.update({'profilePictureAsset': _assetProfileImagePath, 'profilePictureUrl':null});

      await prefs.remove('profileImagePath');
      await prefs.setString('assetProfileImagePath', _assetProfileImagePath!);
    }

    if(mounted){
      Future.delayed(Duration(milliseconds: 300), (){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile picture saved!')),);
      });
    }
  }


  // LOAD IMAGE
  Future<void> _loadProfileImage() async{
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid == null) return;

    final userDocRef = await fire_base_logic.getUserDocument();
    final userData = await userDocRef.get();

    final profileUrl = userData['profilePictureUrl'];
    final assetPath = userData['profilePictureAsset'];


    setState(() {
      if(profileUrl != null && profileUrl != ''){
        _profileImageUrl = profileUrl;
        _assetProfileImagePath = null;
      }
      else if (assetPath != null && assetPath != ''){
        _assetProfileImagePath = assetPath;
        _profileImageUrl = null;
      }
      else {
        _profileImageUrl = null;
        _assetProfileImagePath = null;
      }
    });
  }

  Future<void> _pickCustomImage() async{
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        _profileImage = File(pickedFile.path);
        _assetProfileImagePath = null;
        _profileImageUrl = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Custom image selected!")),
      );
    }
  }



  // SAMPLE IMAGES FOR PROFILE PICTURE
  // ALL FOUND ON PINTEREST!
  Future<void> _pickImage() async {
    final sampleImages = [
      'assets/images/burningComputerCat.jpg',
      'assets/images/vacationCat.jpg',
      'assets/images/employed_cat.jpg',
      'assets/images/money_throw.jpg',
    ];


    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        height: 250,
        child: GridView.count(
          crossAxisCount: 3,
          children: [
            for (var imagePath in sampleImages)
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _assetProfileImagePath = imagePath;
                    _profileImageUrl = null;
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
                    ),
                  ),
                ),
              ),

            // PLUS ICON FOR IMAGE FROM GALLERY
            GestureDetector(
              onTap: () async{
                Navigator.pop(context);
                await _pickCustomImage();
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child: Icon(Icons.add, size: 40),
              )
            )
          ],
        ),
      ),
    );

  }


  // GET CURRENT USER (Google Gemini)
  User? _currentUser;
  Future<void> _fetchCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUser = user;
      });
    }
  }

  // DELETE ACCOUNT WITH PASSWORD (Google Gemini)
  final _deletePasswordController = TextEditingController();
  Future<void> _deleteAccountWithPassword() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: TextField(
            controller: _deletePasswordController,
            decoration: InputDecoration(hintText: 'Enter your password'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                try {
                  // Re-authenticate the user with the entered password.
                  final credential = EmailAuthProvider.credential(
                    email: _currentUser!.email!,
                    password: _deletePasswordController.text,
                  );
                  await _currentUser!.reauthenticateWithCredential(credential);

                  // Delete the user account.
                  await _currentUser!.delete();

                  // Clear the password field.
                  _deletePasswordController.clear();

                  // Navigate to the sign-in/sign-up screen after account deletion.
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (Route<dynamic> route) => false,
                  );

                  // Show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Account deleted successfully!')),
                  );
                } on FirebaseAuthException catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
                }
              },
            ),
          ],
        );
      },
    );
  }

  // CHANGE PASSWORD (Google Gemini)
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  Future<void> _changePassword() async {
    if (_currentUser != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Password'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _oldPasswordController,
                  decoration: InputDecoration(hintText: 'Current Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(hintText: 'New Password'),
                  obscureText: true,
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text('Change'),
                onPressed: () async {
                  try {
                    // Re-authenticate the user with the current password.
                    final credential = EmailAuthProvider.credential(
                      email: _currentUser!.email!,
                      password: _oldPasswordController.text,
                    );
                    await _currentUser!.reauthenticateWithCredential(credential);

                    // Update the password.
                    await _currentUser!.updatePassword(_newPasswordController.text);

                    // Clear the password fields.
                    _oldPasswordController.clear();
                    _newPasswordController.clear();

                    Navigator.of(context).pop(); // Close the dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password updated successfully!')),
                    );
                  } on FirebaseAuthException catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
                  }
                },
              ),
            ],
          );
        }
      );
    }
    }


  // LOG OUT (Google Gemini)
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the sign-in/sign-up screen after sign out.
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthGate()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Handle sign out errors.
      print('Error signing out: $e');
    }
  }

  // GET USER DATA (Google Gemini)
  String? _firstName;
  String? _lastName;
  String? _email;
  Future<void> _fetchUserData() async {
    final userDocRef = await fire_base_logic.getUserDocument();
    final userData = await userDocRef.get();
    _firstName = userData.data()!['First_Name'];
    _lastName = userData.data()!['Last_Name'];
    _email = _currentUser!.email;
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
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : _profileImageUrl != null
                              ? NetworkImage(_profileImageUrl!)
                              : _assetProfileImagePath != null
                                ? AssetImage(_assetProfileImagePath!)
                                : AssetImage('assets/avatar.png') as ImageProvider,
                      ),
                    ),
                    ],
                  ),
                ]
              ),
            ),




                  // NAME AND EMAIL HARDCODED
                  // IMPLEMENT ONCE THERE'S LOGIN/SIGNUP PAGE
                  FutureBuilder<void>(
                    future: Future.wait([_fetchCurrentUser(), _fetchUserData()]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '$_firstName $_lastName',
                              style: TextStyle(fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '$_email',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        );
                      }
                    }
                    ),

            SizedBox(height: 20),
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

            // CHANGE PASSWORD
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              onTap: () async{
                _changePassword();
              }
            ),


            // LOG OUT
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                _signOut();
              },
            ),


            //Delete Account
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete Account',
              style: TextStyle(color: Colors.red)
              ),
              onTap: () {
                _deleteAccountWithPassword();
              },
            ),


          ],
        ),
      ),

    );
  }
}



