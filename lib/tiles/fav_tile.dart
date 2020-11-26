import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_three/datas/fav_products.dart';
import 'package:loja_three/datas/genre_data.dart';
import 'package:loja_three/models/fav_model.dart';

class FavTile extends StatelessWidget {

  final FavProducts favProducts;
  FavTile(this.favProducts);
  @override
  Widget build(BuildContext context) {

    Widget _buildContent(){//mostrar dados do produto
        return Row(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              width: 120.0,
              child: Image.network(
                favProducts.productData.images,
                fit: BoxFit.cover
              ),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      favProducts.productData.title,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500
                      ),
                    ),

                    Text(
                      "Número de eps: ${favProducts.productData.size}",
                      style: TextStyle(
                        fontWeight: FontWeight.w300
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        FlatButton(
                            child: Text(
                              "Remover",
                            ),
                          textColor: Colors.grey,

                          onPressed: (){
                              FavModel.of(context).removeFavItem(favProducts);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: favProducts.productData==null?//se não tiver o productData
            FutureBuilder<DocumentSnapshot>(

              //busca os dados do produto
              future: Firestore.instance.collection("generos").document(favProducts.category)
              .collection("items").document(favProducts.productId).get(),

              //o snapshot aqui é o dado que foi recebido
              //agora do banco de dados
              builder: (context, snapshot){
                if(snapshot.hasData){
                  //salva os dados do produto
                  favProducts.productData = GenreData.fromDocument(snapshot.data);
                  return _buildContent();//mostra os dados
                }

                else{
                  return Container(
                    height: 70.0,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
            )  :

          //se tiver o productData
          _buildContent()//mostra os dados
    );
  }
}
