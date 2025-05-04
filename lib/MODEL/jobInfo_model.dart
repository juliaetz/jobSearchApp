import 'package:flutter/material.dart';

//import 'package:stress_managment_app/account_firebase_logic.dart';

class JobInfoModel{
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;
  set pageIndex(int setValue){
    _pageIndex = setValue;
  }


  /*Future<void> initializeFavIdeasDatabaseRef() async {
    final userDocRef = await getUserDocument();
    favoritesDatabaseReference = userDocRef.collection('Favorite_Ideas');
    eventsDatabaseReference = userDocRef.collection('events');
  }*/
  JobInfoModel();
    //initializeFavIdeasDatabaseRef();
}
