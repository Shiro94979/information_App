import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayInformation extends StatefulWidget {
  @override
  _DisplayInformationState createState() => _DisplayInformationState();
}

class _DisplayInformationState extends State<DisplayInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Personal Information')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                  height: 80.0,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          child: Image.network(
                              "https://cdn.icon-icons.com/icons2/1674/PNG/512/person_110935.png"),
                        ),
                        title: Text(
                          document["fname"] + "   " + document["lname"],
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          document["gender"],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ));
            }).toList(),
          );
        },
      ),
    );
  }
}
