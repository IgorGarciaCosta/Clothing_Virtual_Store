import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_three/datas/genre_data.dart';

class FavProducts{
  String favoriteId;//cid
  String category;
  String productId;//pid

  GenreData productData;

  FavProducts();


  //recebe todos os favoritos e transforma em um FavProduct no banco
  FavProducts.fromDocuemnt(DocumentSnapshot document){
      favoriteId = document.documentID;
      category = document.data["category"];
      productId = document.data["productId"];
  }

  //cria um mapa pra poder coloca rno banco de dados
  Map<String, dynamic>toMap(){
    return{
      "category": category,
      "productId": productId,
      //"product": productData.toResumeMap()//resumo de um produto
    };
  }
}