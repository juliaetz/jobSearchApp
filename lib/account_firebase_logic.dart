import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:cloud_firestore/cloud_firestore.dart';

//Google Gemini Assisted
Future<void> createUserDocument(User? user) async {
    if (user == null) {
      return; // No user is signed in
    }

    final userDocRef =
    FirebaseFirestore.instance.collection('users').doc(user.uid);

    // Check if the user document already exists
    final docSnapshot = await userDocRef.get();
    if (docSnapshot.exists) {
      return; // User document already exists
    }

    //Create user document with an email field to start with
    await userDocRef.set({'User_Email': user.email});
  }

Future<DocumentReference<Map<String, dynamic>>> getUserDocument() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('No user is signed in');
  }
  return FirebaseFirestore.instance.collection('users').doc(user.uid);
}

Future<void> deleteUserData(String userUID) async {
  final userDocRef = FirebaseFirestore.instance.collection('users').doc(userUID);

  // Add collections that a user may have here:
  List<String> collections = ['Career_Goals', 'Favorite_Jobs', 'Favorite_Locations', 'Favorite_Resources'];
  for (String collection in collections) {
    final querySnapshot = await userDocRef.collection(collection).get();
      for (final doc in querySnapshot.docs) {
        doc.reference.delete();
      }
  }
  await userDocRef.delete();
}