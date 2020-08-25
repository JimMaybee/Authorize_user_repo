import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageScreen extends StatelessWidget {
  Stream<QuerySnapshot> getDocuments() {
    return FirebaseFirestore.instance
        .collection('users/K0aIYiW6dmY8MCaBQmh7/messages')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: getDocuments(),
          builder: (context, streamSnapshots) {
            if (streamSnapshots.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final documents = streamSnapshots.data.docs;
            return ListView.builder(
              itemCount: streamSnapshots.data.docs.length,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text('${documents[index].data().toString()}'),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
              .collection('accounts/ZqEbRkLFbW34CXKybmr7/HardCodedImage')
              .add({'HardCoded':'Supposed to be new URL'});
          }),
      ),
    );
  }
}
