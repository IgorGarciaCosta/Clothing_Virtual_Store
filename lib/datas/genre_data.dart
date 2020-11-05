import 'package:cloud_firestore/cloud_firestore.dart';

class GenreData{
  String category;

  String id;
  String title;
  String description;
  int year;
  int size;
  List images;

  GenreData.fromDocument(DocumentSnapshot snapshot){
    //convertendo os dados do documento nos dados da classe
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    year = snapshot.data["year"];
    images = snapshot.data["images"];
    size = snapshot.data["size"];
  }
}