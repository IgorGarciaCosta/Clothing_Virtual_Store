
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_three/datas/fav_products.dart';
import 'package:loja_three/datas/genre_data.dart';
import 'package:loja_three/models/fav_model.dart';
import 'package:loja_three/models/user_models.dart';
import 'package:loja_three/models/user_models.dart';
import 'package:loja_three/screens/login_screen.dart';

import 'fav_screen.dart';

class ProductScreen extends StatefulWidget {
  final GenreData product;
  ProductScreen(this.product);
  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  //essas duas linhas servem pra evitar isar "widget.product" e usar
  //apenas "product"
  final GenreData product;

  bool avaliacao = true;
  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
              aspectRatio: 0.9,
              child: Carousel(
                images: product.images.map((url){
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,//não muda as imagens automaticamente

              ),
          ),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,//tenta ocupar o máx espaço disp
                children: <Widget>[
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500
                    ),
                    maxLines: 3,
                  ),
                  Text("Ano de lançamento: ${product.year}",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        ),
                  ),
                  SizedBox(height: 25.0,),
                  Text(//número de eps
                    "Número de episódios: ${product.size}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 25.0,),

                  Text(//descrição
                    "Descrição:",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),

                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16.0
                    ),
                  ),

                  SizedBox(height: 40.0,),

                  SizedBox(//botão de favoritar
                    height: 44.0,

                    child: avaliacao?
                      RaisedButton(
                        onPressed: (){

                          //se estiver logado
                          if(UserModel.of(context).isLoggedIn()){
                            setState(() {
                              avaliacao = !avaliacao;
                              //product.fav = avaliacao;
                              print(avaliacao);

                              FavProducts favProduct = FavProducts();
                              favProduct.productId = product.id;
                              favProduct.category = product.category;

                              FavModel.of(context).addFavItem(favProduct);

                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context)=>FavScreen()
                                  )
                              );
                            });
                          }

                          else{//se estiver deslogado
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context)=>LoginScreen()
                              )
                            );
                          }

                        },

                        child:
                              Text("Adicionar aos Favoritos",
                                  style: TextStyle(fontSize: 18.0),),


                        color: primaryColor,
                        textColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)
                        ),

                    )
                        :
                     RaisedButton(
                       onPressed: (){
                         //se estiver logado
                         if(UserModel.of(context).isLoggedIn()){
                           setState(() {
                             avaliacao = !avaliacao;
                             //product.fav = avaliacao;
                             print(avaliacao);
                           });
                         }

                         else{//se estiver deslogado
                           Navigator.of(context).push(
                               MaterialPageRoute(
                                   builder: (context)=>LoginScreen()
                               )
                           );
                         }
                       },

                       child:
                       Text("Favorito",
                         style: TextStyle(fontSize: 18.0),),


                       color: Color(0XFF3eb54e),
                       textColor: Colors.white,
                       shape: new RoundedRectangleBorder(
                           borderRadius: new BorderRadius.circular(30.0)
                       ),

                     ),
                  ),
                ],
              ),
          )
        ],
      ),
    );
  }
}
