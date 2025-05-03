import 'package:final_project/MODEL/careergoals_model.dart';
import 'package:final_project/PRESENTER/careergoals_presenter.dart';
import 'package:flutter/material.dart';

class CareerGoalsPage extends StatefulWidget {
  const CareerGoalsPage({Key? key}) : super(key: key);
  @override
  _CareerGoalsPageState createState() => _CareerGoalsPageState();
}

class _CareerGoalsPageState extends State<CareerGoalsPage> {
  final presenter = CareerGoalsPresenter();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Career Goals"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: StreamBuilder<List<CareerGoal>>(
                  stream: presenter.getCareerGoals(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }else if(snapshot.hasError){
                      return Text('Error: ${snapshot.error}');
                    }else if(!snapshot.hasData || snapshot.data!.isEmpty){
                      return Center(child: Text('No entries yet!'));
                    }
                    List<CareerGoal> goals = snapshot.data!;
                    return ListView.builder(
                      itemCount: goals.length,
                      itemBuilder: (context, index){
                        CareerGoal goal = goals[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:Colors.greenAccent,
                            borderRadius:BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Text(goal.goal, style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(goal.goalType.toString()),
                          ),
                        );
                      }
                    );
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}