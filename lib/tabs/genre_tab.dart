import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GenreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("generos").getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);

        }
        else{
          return ListView(
            children: <Widget>[

            ],
          );
        }
      },
    );
  }
}
