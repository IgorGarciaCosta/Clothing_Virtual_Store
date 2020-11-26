import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ItemModel extends Model{

  Map<String, dynamic> itemData = Map();

  void tste(){
    print("oi");
  }

  void adicionaItemNoBanco({@required Map<String, dynamic> itemData, @required String generoDoAnime ,@required File img}){
        //String imagemUrl = itemData["imagem"].toString();
        //String imagemUrlCutted = imagemUrl.substring(6);

        //itemData["imagem"] = imagemUrlCutted;

        print(itemData["title"]);
        print(itemData["year"]);
        print(itemData["size"]);
        print(itemData["description"]);
        print(itemData["images"]);
        //Firestore.instance.collection("generos").document(itemData["genero"]).collection("items").add(itemData);
        adicionaImagemNoBanco(itemData, img, generoDoAnime);
  }

  void adicionaImagemNoBanco(Map<String, dynamic> itemData, File img, String generoDoAnime) async{
    if(itemData["images"] != null){
      StorageUploadTask task = FirebaseStorage
          .instance
          .ref()
          .child("generos")
          .child(generoDoAnime)
          .child("item").putFile(itemData["images"]);

          StorageTaskSnapshot taskSnapshot = await task.onComplete;
          String url = await taskSnapshot.ref.getDownloadURL();
          itemData["images"] = url;

          Firestore.instance.collection("generos").document(generoDoAnime).collection("items").add(itemData);

          //.collection("generos")
          //.document(itemData["genero"])
          //.collection("items").putFile(itemData["images"]);
    }
  }

}