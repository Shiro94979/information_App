import 'package:flutter/material.dart';
import 'package:information_app/screen/displayinformation.dart';
import 'package:information_app/screen/formscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( 
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            FormScreen(),
            DisplayInformation(),
          ],
        ),
        backgroundColor: Colors.blue[400],
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(text: "Information Register",),
            Tab(text: "Information List")
          ],),
      ));
  }
}
