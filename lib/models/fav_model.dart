import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_three/datas/fav_products.dart';
import 'package:loja_three/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

class FavModel extends Model{

  UserModel user;

  List<FavProducts>products = [];

  bool isLoading = false;

  FavModel(this.user) {//faz o favModel ter acesso aos usuários
    if(user.isLoggedIn())
      _loadFavItems();
  }

  //feito pra acessar o favModel de qualquer lugar do app
  static FavModel of(BuildContext context)=>
      ScopedModel.of<FavModel>(context);

  void addFavItem(FavProducts favProducts){
    int tamanho = products.length;
    int repetidos = 0;
    for (int i =0; i< tamanho; i++){
      print(products[i].productId);
      print(favProducts.productId);

      if(products[i].productId == favProducts.productId){
        print("\n\niguais: ${products[i].productId} e ${favProducts.productId}");
        repetidos++;
        print("\nrepetiu aqui");
      }
    }

    if(repetidos ==0){
      print("\nnão houve reptidos");
      products.add(favProducts);
      Firestore.instance.collection("users").document(user.firebaseUser.uid)
          .collection("fav").add(favProducts.toMap()).
      then((doc){
        favProducts.favoriteId = doc.documentID;//salva o id dado pelo firebase aqui
      });
      notifyListeners();
    }



  }

  void removeFavItem(FavProducts favProducts){
    Firestore.instance.collection("users").document(user.firebaseUser.uid).
    collection("fav").document(favProducts.favoriteId).delete();

    products.remove(favProducts);

    notifyListeners();
  }

  void _loadFavItems() async{
    QuerySnapshot query = await Firestore.instance.collection("users").
    document(user.firebaseUser.uid).collection("fav").getDocuments();

    //transforma cada documento retornado do firebase
    //em um FavProduct e retorna uma lista com todos esses
    //FavProducts
    products = query.documents.map((doc) => FavProducts.fromDocument(doc)).toList();
    notifyListeners();
  }
}