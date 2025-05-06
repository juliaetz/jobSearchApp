import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data_read.dart';
import '../account_firebase_logic.dart';

class SoftwareJobsModel{
  int _pageIndex = 0;
  //CollectionReference jobsDatabaseReference = FirebaseFirestore.instance.collection('Favorite_Jobs');
  Map<int,bool> favoritedData = <int,bool>{};


  int get pageIndex => _pageIndex;
  set pageIndex(int setValue){
    _pageIndex = setValue;
  }


  /*Future<void> initializeFavIdeasDatabaseRef() async {
    final userDocRef = await getUserDocument();
    favoritesDatabaseReference = userDocRef.collection('Favorite_Ideas');
    eventsDatabaseReference = userDocRef.collection('events');
  }*/
  Future<CollectionReference> getJobsDatabaseReference() async {
    final userDocRef = await getUserDocument();
    return userDocRef.collection('Favorite_Jobs');
  }
  SoftwareJobsModel();
//initializeFavIdeasDatabaseRef();
}