import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/VIEW/jobHomePage.dart';
import 'package:final_project/VIEW/darkTheme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',


      // LIGHT AND DARK THEME
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,



      // PAGE ROUTES
      initialRoute: '/',
      routes: {
        '/': (context) => JobHomePage(),
      },
    );
  }
}


/*

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

   */




