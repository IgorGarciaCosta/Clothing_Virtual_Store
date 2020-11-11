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


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

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

  void signIn({@required String email, @required String password
    , @required VoidCallback onSuccess, @required VoidCallback onFail}){

    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((user)async {
        firebaseUser = user;

        await _loadCurrentUser();
        onSuccess();
        isLoading = false;
        notifyListeners();
    } ).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });
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

  Future<Null> _loadCurrentUser()async{
    if(firebaseUser == null){
      firebaseUser = await _auth.currentUser();
    }
    if(firebaseUser !=null){//logou com sucesso
      if(userData["name"]==null){
        DocumentSnapshot docUser = await Firestore.instance
        .collection("users").document(firebaseUser.uid).get();

        userData = docUser.data;
      }
    }
    notifyListeners();
  }
}