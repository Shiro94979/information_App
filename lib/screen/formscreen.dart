import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:information_app/model/personal_Info.dart';

class FormScreen extends StatefulWidget {
  FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formkey = GlobalKey<FormState>();
  PersonalInfo myPersonalInfo = PersonalInfo();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  // CollectionReference _infomationcollection =
  //     FirebaseFirestore.instance.collection("Personal Info");
  CollectionReference _informationcollection =
    FirebaseFirestore.instance.collection("Personal Information");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('"Error'),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Infomation"),
              ),
              body: Container(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "First Name",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: 'Please Fill Information'),
                          onSaved: (String? fname) {
                            myPersonalInfo.fname = fname;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Last Name",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: 'Please Fill Information'),
                          onSaved: (String? lname) {
                            myPersonalInfo.lname = lname;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Gender",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: 'Please Fill Information'),
                          onSaved: (String? gender) {
                            myPersonalInfo.gender = gender;
                          },
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("Save"),
                              onPressed: () async{
                                if (formkey.currentState!.validate()) {
                                  formkey.currentState!.save();
                                    await _informationcollection.add({
                                      "fname": myPersonalInfo.fname,
                                      "lname": myPersonalInfo.lname,
                                      "gender": myPersonalInfo.gender,
                                    });
                                    formkey.currentState!.reset();
                                  
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
    );
  }
}
