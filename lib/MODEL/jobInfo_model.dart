import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data_read.dart';
//import 'package:stress_managment_app/account_firebase_logic.dart';

class JobInfoModel{
  CollectionReference jobsDatabaseReference = FirebaseFirestore.instance.collection('Favorite_Jobs');
  CollectionReference interviewsDatabaseReference = FirebaseFirestore.instance.collection("Interviews");
  Map<String,favoriteJob> favoritesList = <String,favoriteJob>{};


  /*Future<void> initializeFavIdeasDatabaseRef() async {
    final userDocRef = await getUserDocument();
    favoritesDatabaseReference = userDocRef.collection('Favorite_Ideas');
    eventsDatabaseReference = userDocRef.collection('events');
  }*/
  JobInfoModel();
    //initializeFavIdeasDatabaseRef();
}
