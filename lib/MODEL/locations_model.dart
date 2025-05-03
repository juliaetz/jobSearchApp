import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:stress_managment_app/firebase_logic.dart';

class LocationsModel{
  int _pageIndex = 0;
  CollectionReference locationsDatabaseReference = FirebaseFirestore.instance.collection('Favorite_Locations');
  Map<int,bool> softwareFavorited = <int,bool>{};
  Map<int,bool> dataFavorited = <int,bool>{};

  int get pageIndex => _pageIndex;
  set pageIndex(int setValue){
    _pageIndex = setValue;
  }


  /*Future<void> initializeFavIdeasDatabaseRef() async {
    final userDocRef = await getUserDocument();
    favoritesDatabaseReference = userDocRef.collection('Favorite_Ideas');
    eventsDatabaseReference = userDocRef.collection('events');
  }*/
  LocationsModel();
//initializeFavIdeasDatabaseRef();
}