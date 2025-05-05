import 'package:final_project/MODEL/careergoals_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../account_firebase_logic.dart';

class CareerGoalsPresenter{

  Future<void> addCareerGoal(CareerGoal goal) async {
      DocumentReference userDocRef = await getUserDocument();
      await userDocRef.collection('Career_Goals').add(goal.toMap());
  }

  Stream<List<CareerGoal>> getCareerGoals()  {
    return Stream.fromFuture(getUserDocument()).asyncExpand((userDoc) {
      return userDoc
          .collection('Career_Goals')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
                return CareerGoal.fromMap(doc.data(), doc.id);
              }).toList());
    });

  }

  Future<void> deleteGoal(String id) async {
    DocumentReference userDocRef = await getUserDocument();
    await userDocRef.collection('Career_Goals').doc(id).delete();
  }

  Future<void> completeGoal(String id) async {
    DocumentReference userDocRef = await getUserDocument();
    await userDocRef.collection('Career_Goals').doc(id).update({'isCompleted': true});
    await userDocRef.collection('Career_Goals').doc(id).update({'completionDate': DateTime.now()});
  }

}