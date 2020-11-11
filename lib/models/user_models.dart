import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model{
  //obs: Model é um objeto que guarda os estados de algo
  //nesse caso, os estados do login do app

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  void signUp({@required Map<String, dynamic> userData, @required String password,
    @required VoidCallback onSuccess, @required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(//tenta criar usuário
        email: userData["email"],
        password: password
    ).then((user) async{//se funcionar, chama essa função
      firebaseUser = user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();//informa que terminou de carregar
    }).catchError((e){//se não funcionar, chama essa
        onFail();
        isLoading = false;
        notifyListeners();
    });

  }

  void signIn(){

  }

  void signOut() async{
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPassword(){

  }

  bool isLoggedIn(){
      return firebaseUser != null;//indica usuario logado
  }

  //só essa função tem "_" pq apenas ela não pode ser
  //chamada de fora
  Future<Null>_saveUserData(Map<String, dynamic> userData) async{
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }
}