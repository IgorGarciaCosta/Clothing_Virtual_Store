import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_three/models/fav_model.dart';
import 'package:loja_three/models/user_models.dart';
import 'package:loja_three/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class FavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Favoritos"),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<FavModel>(
              builder: (context, child, model){
                int quantidade = model.products.length;
                return Text(
                  
                    //se quant. == null, retorna 0, se não for, retorna o val. de quant.
                    "${quantidade ?? 0} ${quantidade==1 ?"ITEM":"ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<FavModel>(
        builder: (context, child, model) {
          if(model.isLoading && UserModel.of(context).isLoggedIn()){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          else if(!UserModel.of(context).isLoggedIn()){//se o usuário n está logado
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  Icon(Icons.favorite_border,size: 80.0, color:Theme.of(context).primaryColor),
                  SizedBox(height: 16.0,),
                  Text("Faça o login para adicionar itens",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),

                  SizedBox(height: 16.0,),

                  RaisedButton(
                    child: Text("Entrar",
                      style: TextStyle(fontSize: 18.0),),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder:(context)=>LoginScreen() )
                      );
                    },
                  )
                ],
              ),
            );
          }

          //se estiver sem favoritos
          else if(model.products ==null || model.products.length ==0){
            return Center(
              child: Text("Sem animes favoritos T-T",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
            );

          }
        }
      ),
    );
  }
}
