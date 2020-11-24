import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemModel extends Model{

  Map<String, dynamic> itemData = Map();

  void tste(){
    print("oi");
  }

  void adicionaItemNoBanco({@required Map<String, dynamic> itemData, @required String genero}){
        print(itemData["title"]);
        print(itemData["year"]);
        print(itemData["size"]);
        print(itemData["description"]);
        
        Firestore.instance.collection("generos").document(genero).collection("items").add(itemData);
  }

}