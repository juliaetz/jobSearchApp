import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../account_firebase_logic.dart';

import 'data_read.dart';

class DataJobsModel{
  int _pageIndex = 0;
  bool isJobsInitialized = false;
  Map<int,bool> favoritedData = <int,bool>{};


  int get pageIndex => _pageIndex;
  set pageIndex(int setValue){
    _pageIndex = setValue;
  }

  Future<CollectionReference> getJobsDatabaseReference() async {
    final userDocRef = await getUserDocument();
    return userDocRef.collection('Favorite_Jobs');
  }
  DataJobsModel();
}