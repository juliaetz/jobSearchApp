import 'package:final_project/MODEL/careergoals_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CareerGoalsPresenter{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> addCareerGoal(CareerGoal goal) async {
      await firestore.collection('careerGoals').add(goal.toMap());
  }

  Stream<List<CareerGoal>> getCareerGoals() {
    return firestore.collection('careerGoals').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CareerGoal.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<void> deleteGoal(String id) async {
    await firestore.collection('careerGoals').doc(id).delete();
  }

  Future<void> completeGoal(String id) async {
    await firestore.collection('careerGoals').doc(id).update({'isCompleted': true});
    await firestore.collection('careerGoals').doc(id).update({'completedAt': DateTime.now()});
  }

}