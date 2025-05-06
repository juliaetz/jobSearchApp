import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data_read.dart';
import '../account_firebase_logic.dart';

class JobInfoModel{
  CollectionReference jobsDatabaseReference = FirebaseFirestore.instance.collection('Favorite_Jobs');
  CollectionReference interviewsDatabaseReference = FirebaseFirestore.instance.collection("Interviews");
  Map<String,favoriteJob> favoritesList = <String,favoriteJob>{};

  Future<CollectionReference> getJobsDatabaseReference() async {
    final userDocRef = await getUserDocument();
    return userDocRef.collection('Favorite_Jobs');
  }

  Future<CollectionReference> getInterviewsDatabaseReference() async {
    final userDocRef = await getUserDocument();
    return userDocRef.collection('Interviews');
  }
  JobInfoModel();
}
