import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'articleInfo.dart';
import '../account_firebase_logic.dart';

class ResourcesModel{
  int _pageIndex = 0;
  Map<int,bool> favorited = <int,bool>{};
  Map<String,articleInfo> favoritesList = <String,articleInfo>{}; // String = url

  int get pageIndex => _pageIndex;
  set pageIndex(int setValue){
    _pageIndex = setValue;
  }

  Future<CollectionReference> getResourcesDatabaseReference() async {
    final userDocRef = await getUserDocument();
    return userDocRef.collection('Favorite_Resources');
  }
  ResourcesModel();
}