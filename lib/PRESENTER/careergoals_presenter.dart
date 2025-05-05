import 'package:final_project/MODEL/careergoals_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CareerGoalsPresenter{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> addCareerGoal(CareerGoal goal) async {
      await firestore.collection('Career_Goals').add(goal.toMap());
  }

  Stream<List<CareerGoal>> getCareerGoals() {
    return firestore.collection('Career_Goals').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CareerGoal.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> deleteGoal(String id) async {
    await firestore.collection('Career_Goals').doc(id).delete();
  }

  Future<void> completeGoal(String id) async {
    await firestore.collection('Career_Goals').doc(id).update({'isCompleted': true});
    await firestore.collection('Career_Goals').doc(id).update({'completionDate': DateTime.now()});
  }

  // ✱ Interview methods ───────────────────

  /// Schedule a new interview
  Future<void> addInterview(String title, DateTime dateTime) async {
    await firestore
        .collection('Interviews')
        .add(Interview(id: '', title: title, dateTime: dateTime).toMap());
  }

  /// Stream all interviews as a List<Interview>
  Stream<List<Interview>> getInterviews() {
    return firestore.collection('Interviews').snapshots().map((snap) {
      return snap.docs
          .map((doc) => Interview.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  /// Delete an interview
  Future<void> deleteInterview(String id) async {
    await firestore.collection('Interviews').doc(id).delete();
  }
}
