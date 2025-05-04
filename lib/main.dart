import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/VIEW/jobHomePage.dart';
import 'package:final_project/VIEW/darkTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_gate.dart';
import 'package:final_project/VIEW/account_screens/sign_in_view.dart';
import 'package:final_project/VIEW/account_screens/sign_up_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/': (context) => AuthGate(),
        '/home': (context) => JobHomePage(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
      },
    );
  }
}




