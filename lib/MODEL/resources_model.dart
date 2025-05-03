import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:stress_managment_app/firebase_logic.dart';
import 'articleInfo.dart';

class ResourcesModel{
  int _pageIndex = 0;
  CollectionReference resourcesDatabaseReference = FirebaseFirestore.instance.collection('Favorite_Resources');
  Map<int,bool> favorited = <int,bool>{};
  Map<String,articleInfo> favoritesList = <String,articleInfo>{}; // String = url

  int get pageIndex => _pageIndex;
  set pageIndex(int setValue){
    _pageIndex = setValue;
  }


  /*Future<void> initializeFavIdeasDatabaseRef() async {
    final userDocRef = await getUserDocument();
    favoritesDatabaseReference = userDocRef.collection('Favorite_Ideas');
    eventsDatabaseReference = userDocRef.collection('events');
  }*/
  ResourcesModel();
//initializeFavIdeasDatabaseRef();
}