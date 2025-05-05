import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../account_firebase_logic.dart';

class LocationsModel{
  int _pageIndex = 0;
  Map<int,bool> softwareFavorited = <int,bool>{};
  Map<int,bool> dataFavorited = <int,bool>{};
  Map<String,String> favoritesList = <String,String>{};

  int get pageIndex => _pageIndex;
  set pageIndex(int setValue){
    _pageIndex = setValue;
  }
  Future<CollectionReference> getLocationsDatabaseReference() async {
    final userDocRef = await getUserDocument();
    return userDocRef.collection('Favorite_Locations');
  }

  LocationsModel();
}