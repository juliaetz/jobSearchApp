import 'package:flutter/material.dart';
import 'MODEL/data_read.dart';
import 'PRESENTER/load_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final repo = JobRepository();
  List<Job> jobs = [];

  @override
  void initState() {
    super.initState();
    repo.loadAndSort().then((list) {
      setState(() => jobs = list);
      // for now, just print top 5:
      for (var j in jobs.take(5)) {
        print('${j.title} @ ${j.company}, ${j.location}: \$${j.avgSalary}');
      }
      //DELETE ABOVE ^^^^^
    });
  }

  @override
  Widget build(BuildContext context) {
    // later: build ListView, add search/filter, compare by city, …
    return Scaffold(
      appBar: AppBar(title: Text('Salaries')),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (_, i) {
          final j = jobs[i];
          return ListTile(
            title: Text(j.title),
            subtitle: Text('${j.company} • ${j.location}'),
            trailing: Text('\$${j.avgSalary}'),
          );
        },
        //DELETE ABOVE ^^^^^^^^
      ),
    );
  }
}

